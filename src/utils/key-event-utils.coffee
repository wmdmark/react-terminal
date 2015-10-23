historyScrollOffset = 0

module.exports = 
  
  reduceKeyDown: (input, cursorPosition, prompt, history, e)->
    if e.keyCode in [37, 39, 8, 13, 38, 40]
      e.preventDefault()
    
    switch e.keyCode
      when 13 
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
    
    return [input, cursorPosition, history]

  reduceKeyPress: (input, cursorPosition, e)->
    e.preventDefault()
    char = String.fromCharCode(e.keyCode)
    input = input.substring(0, cursorPosition) + char + input.substring(cursorPosition, input.length)
    cursorPosition++
    return [input, cursorPosition]

  getPromptStrings: (input, cursorPosition)->
    left = input.substring(0, cursorPosition)
    right = input.substring(cursorPosition+1, input.length)
    cursor = if cursorPosition < (input.length)
      input[cursorPosition]
    else
      "\u00a0"
    return [left, cursor, right]
