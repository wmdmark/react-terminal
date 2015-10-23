keyEventUtils = require("../utils/key-event-utils")
Terminal = require("./Terminal")

class TerminalContainer extends React.Component

  componentWillMount: ->
    @state = @props.initialState

  componentDidMount: ->
    document.addEventListener("keydown", @onKeyDown)
    document.addEventListener("keypress", @onKeyPress)

  componentWillUnmount: ->
    document.removeEventListener("keydown", @onKeyDown)
    document.removeEventListener("keypress", @onKeyPress)

  onKeyDown: (event)=>
    # Key down listens for cursor movement + enter key
    [input, cursorPosition, history] = keyEventUtils.reduceKeyDown(
      @state.input, 
      @state.cursorPosition, 
      @state.prompt,
      @state.history, 
      event
    )
    @setState({input, cursorPosition, history})

  onKeyPress: (event)=>
    # Key press is a typed character
    [input, cursorPosition] = keyEventUtils.reduceKeyPress(
      @state.input, 
      @state.cursorPosition, 
      event
    )
    @setState({input, cursorPosition})

  render: ->
    <Terminal {...@state} />

module.exports = TerminalContainer