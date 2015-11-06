commands = require("../commands")

reduceKey = (state, event)->
  updates = null

  if event.type is "keydown"
    if event.keyCode in [37, 39, 8, 13, 38, 40]
      updates = reduceKeyControl(state, event)
      if updates.command
        state = _.assign state, updates
        updates = _.assign updates, reduceCommand(state, updates.command)
  else
    # character
    updates = reduceCharacter(state, event)

  if state.recording and updates
    updates = _.assign updates, reduceInputRecording(state, event)

  return updates

clearBuffer = (state)->
  {lines, input, prompt} = state
  # go ahead and push the last input from buffer
  lines.push({input, prompt})
  state = _.assign {}, state, {buffer: [], lines: lines,  playing: no, recording: no, input: "", cursorPosition: 0}
  return state

reduceError = (state, error)->
  {buffer} = state
  buffer.push({prompt: "error >>", input: error.message, color: "red"})
  return _.assign {}, state, {buffer}

reduceBuffer = (state)->
  {buffer, lines} = state

  return new Promise (resolve, reject)->
    {buffer, lines} = state
    if buffer.length > 0
      next = buffer.shift()
      resolve(reduceBufferedItem(state, next))
    else
      reject(new Error("Buffer is empty"))

reduceBufferedItem = (state, bufferedItem)->
  # items in buffer can be
  # - string (a simple line w/ optional prompt)
  # - object: a line object (prompt, input, color)
  # - event: a character event (will be processed as a key input)
  # - promise (must resolve to one of the above)
  # - array of strings/objects

  processError = (error)->
    new Promise (resolve)->
      resolve(processString("Error: #{error.toString()}"))

  processString = (bufferedString)->
    new Promise (resolve)->
      {lines} = state
      input = bufferedString
      prompt = null
      if input.indexOf("::") > -1
        [prompt, input] = input.split("::")
      lines.push({prompt, input})
      resolve {lines}

  processPromise = (bufferedPromise)->
    new Promise (resolve)->
      bufferedPromise
        .then (result)->
          resolve(processBuffered(result))
        .catch(processError)

  processLine = (bufferedLine)->
    new Promise (resolve)->
      {lines} = state
      # TODO: handle delay
      lines.push(bufferedLine)
      resolve({lines})

  processEvent = (bufferedEvent)->
    new Promise (resolve)->
      _.delay ->
        resolve(reduceKey(state, bufferedEvent.event))
      , bufferedEvent.time or 0


  new Promise (resolve, reject)->

    resolveState = (promise)->
      promise
        .then (updates)->
          resolve(_.assign {}, state, updates)
        .catch (err)->
          reject(err)

    if _.isString bufferedItem
      resolveState(processString(bufferedItem))
    else if _.isFunction(bufferedItem.then)
      resolveState(processPromise(bufferedItem))
    else if _.isObject(bufferedItem)
      if bufferedItem.event
        resolveState(processEvent(bufferedItem))
      else
        resolveState(processLine(bufferedItem))
    else if _.isArray(bufferedItem)
      resolveState(processArray(bufferedItem))
    else
      reject(new Error("Unrecognized item in buffer: ", bufferedItem))

reduceCommand = (state, commandData)->
  {command, args} = commandData
  commandFunc = commands[command]
  if commandFunc
    return commandFunc.bind(commands)(state, args...)
  else if !(state.recording or state.playing)
    state.buffer.push(input: "Command \"#{command}\" not found.", color: "red")
    return {buffer: state.buffer}

reduceInputRecording = (state, event)->
  {recordStartTime, recordedInput} = state
  ms = 0
  now = new Date()
  if recordedInput.length > 0
    lastEvent = recordedInput[recordedInput.length-1]
    ms = now - lastEvent.date
  recordedEvent =
    type: event.type
    keyCode: event.keyCode
  recordedInput.push({event: recordedEvent, date: now, time: ms})
  {recordStartTime, recordedInput}

reduceCharacter = (state, event)->
  {input, cursorPosition} = state
  char = String.fromCharCode(event.keyCode)
  input = input.substring(0, cursorPosition) + char + input.substring(cursorPosition, input.length)
  cursorPosition++
  {input, cursorPosition, command: null}

reduceKeyControl = (state, event)->
  {input, cursorPosition, prompt, history, lines, historyScrollOffset} = state
  command = null
  switch event.keyCode
    when 13
      parts = input.split(" ")
      command = _.trim(parts[0].toLowerCase())
      args = parts[1..]
      command = {command, args}
      if command.length is 0
        command = null

      # enter key
      lines.push({prompt, input})
      if not state.playing
        history.push({prompt, input})
        historyScrollOffset = 0
      input = ""
      cursorPosition = 0
    when 37
      # left arrow
      if cursorPosition > 0
        cursorPosition = cursorPosition - 1
    when 39
      # right arrow
      if cursorPosition < input.length
        cursorPosition = cursorPosition + 1
    when 38
      # up arrow
      pos = (history.length + (historyScrollOffset-1))
      if pos > 0
        historyScrollOffset--
        input = history[pos].input
        cursorPosition = input.length
    when 40
      # down arrow
      pos = (history.length + (historyScrollOffset+1))
      if pos < history.length
        historyScrollOffset++
        input = history[pos].input
        cursorPosition = input.length
    when 8
      # backspace
      if input.length <= 1
        input = ""
      else
        input = input.substring(0, cursorPosition-1) + input.substring(cursorPosition, input.length)
        if cursorPosition >= 1
          cursorPosition = cursorPosition - 1
        else
          cursorPosition = 0

  return {input, cursorPosition, history, command, historyScrollOffset}

getPromptStrings = (input, cursorPosition)->
  left = input.substring(0, cursorPosition)
  right = input.substring(cursorPosition+1, input.length)
  cursor = if cursorPosition < (input.length)
    input[cursorPosition]
  else
    "\u00a0"
  return [left, cursor, right]

module.exports = {getPromptStrings, reduceKey, reduceBuffer, clearBuffer, reduceError}
