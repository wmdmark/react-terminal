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
    #console.log "onKeyDown", e.keyCode
    switch e.keyCode
      when 37
        # left arrow
        e.preventDefault()
        if @state.cursorPosition > 0
          @setState
            cursorPosition: @state.cursorPosition - 1
      when 39
        # right arrow
        e.preventDefault()
        if @state.cursorPosition < @state.input.length
          @setState
            cursorPosition: @state.cursorPosition + 1
      when 8
        # backspace
        e.preventDefault()

        cp = @state.cursorPosition
        if @state.input.length <= 1
          input = ""
        else
          input = @state.input
          cp = @state.cursorPosition
          input = input.substring(0, cp-1) + input.substring(cp, input.length)
          if cp >= 1
            cp = @state.cursorPosition - 1
          else
            cp = 0
        @setState
          input: input
          cursorPosition: cp
      when 13
        # enter key
        e.preventDefault()
        @props.onSubmit(@state.input)
        @setState(input: "", cursorPosition: 0)

  onKeyPress: (e)->
    e.preventDefault()
    input = @state.input
    cp = @state.cursorPosition
    char = String.fromCharCode(e.keyCode)
    input = input.substring(0, cp) + char + input.substring(cp, input.length)
    input = input.replace(/ /g, "\u00a0")
    @setState
      input: input
      cursorPosition: @state.cursorPosition + 1

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
      { @state.history.map (line)-> <Line line={line} /> }
      <Prompt onSubmit={@onPromptSubmit} />
    </div>

module.exports = Terminal