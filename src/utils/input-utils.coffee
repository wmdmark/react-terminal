historyScrollOffset = 0

module.exports =

  addLine: (state, input, prompt=null, color=null)->
    history = state.history
    history.push({input, prompt, color})
    return _.extend {}, state, {history}

  reduceKeyDown: (state, event)->
    {input, cursorPosition, prompt, history} = state

    command = null

    if event.keyCode in [37, 39, 8, 13, 38, 40]
      event.preventDefault()

    switch event.keyCode
      when 13
        parts = input.split(" ")
        command = parts[0]
        args = parts[1..]
        command = {command, args}
        
        # enter key
        history.push({prompt, input})
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
        # up arrow
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

    state = _.extend {}, state, {input, cursorPosition, history, command}
    return state

  reduceKeyPress: (state, event)->
    event.preventDefault()
    {input, cursorPosition} = state
    char = String.fromCharCode(event.keyCode)
    input = input.substring(0, cursorPosition) + char + input.substring(cursorPosition, input.length)
    cursorPosition++
    state = _.extend {}, state, {input, cursorPosition}
    return state

  getPromptStrings: (input, cursorPosition)->
    left = input.substring(0, cursorPosition)
    right = input.substring(cursorPosition+1, input.length)
    cursor = if cursorPosition < (input.length)
      input[cursorPosition]
    else
      "\u00a0"
    return [left, cursor, right]
