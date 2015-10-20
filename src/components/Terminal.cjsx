reduceKeyDown = (input, cursorPosition, e)->
  if input.length is 0 and e.keyCode in [37, 39, 8]
    e.preventDefault()
    return [input, cursorPosition]
  switch e.keyCode
    when 37
      # left arrow
      e.preventDefault()
      if cursorPosition > 0
        cursorPosition = cursorPosition - 1
    when 39
      # right arrow
      e.preventDefault()
      if cursorPosition < input.length
        cursorPosition = cursorPosition + 1
    when 8
      # backspace
      e.preventDefault()
      if input.length <= 1
        input = ""
      else
        input = input.substring(0, cursorPosition-1) + input.substring(cursorPosition, input.length)
        if cursorPosition >= 1
          cursorPosition = cursorPosition - 1
        else
          cursorPosition = 0
  return [input, cursorPosition]

reduceKeyPress = (input, cursorPosition, e)->
  e.preventDefault()
  # Don't allow multiple spaces
  if e.keyCode is 32 and input.length >= 2 # space
    prevChar = input[cursorPosition-2] 
    if not prevChar? or prevChar is ' '
      console.log "abort space"
      return [input, cursorPosition]
  char = String.fromCharCode(e.keyCode)
  input = input.substring(0, cursorPosition) + char + input.substring(cursorPosition, input.length)
  #input = input.replace(/ /g, "\u00a0")
  cursorPosition++
  return [input, cursorPosition]

Line = React.createClass
  
  displayName: "Line"
  
  render: ->
    <div className="Line">{@props.line}</div>

Prompt = React.createClass
  
  displayName : "Prompt"
  
  getInitialState: ->
    input: ""
    cursorPosition: 0

  componentDidMount: ->
    document.addEventListener("keydown", @onKeyDown)
    document.addEventListener("keypress", @onKeyPress)

  componentWillUnmount: ->
    document.removeEventListener("keydown", @onKeyDown)
    document.removeEventListener("keypress", @onKeyPress)

  onKeyDown: (e)->
    if e.keyCode is 13
      # enter key
      e.preventDefault()
      @props.onSubmit(@state.input)
      @setState(input: "", cursorPosition: 0)
    else
      [input, cursorPosition] = reduceKeyDown(@state.input, @state.cursorPosition, e)
      @setState({input, cursorPosition})

  onKeyPress: (e)->
    [input, cursorPosition] = reduceKeyPress(@state.input, @state.cursorPosition, e)
    @setState({input, cursorPosition})

  render: ->
    {input, cursorPosition} = @state
    if cursorPosition > 0
      linput = input.substring(0, cursorPosition)
    if cursorPosition < (input.length)
      cursorChar = input[cursorPosition]
    else
      cursorChar = "\u00a0"
    rinput = input.substring(cursorPosition+1, input.length)
    <div className="Prompt">
      <span className="Prompt__from">input:</span>
      {
        if linput
          <span>{linput}</span>
      }
      <span className="Prompt__cursor">{cursorChar}</span>
      <span>{rinput}</span>
    </div>


Terminal = React.createClass

  displayName: "Terminal"

  getInitialState: ->
    history: []

  onPromptSubmit: (command)->
    history = @state.history
    history.push(command)
    @setState
      history: history

  render: ->
    <div className="Terminal">
      { @state.history.map (line, index)-> <Line key={index} line={line} /> }
      <Prompt onSubmit={@onPromptSubmit} />
    </div>

module.exports = Terminal