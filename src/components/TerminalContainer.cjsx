inputUtils = require("../utils/input-utils")
Terminal = require("./Terminal")



class TerminalContainer extends React.Component

  componentWillMount: ->
    {@state} = @props

  componentDidMount: ->
    document.addEventListener("keydown", @onKeyDown)
    document.addEventListener("keypress", @onKeyPress)

  componentWillUnmount: ->
    document.removeEventListener("keydown", @onKeyDown)
    document.removeEventListener("keypress", @onKeyPress)

  addLine: (line, prompt)->
    state = _.extend {}, inputUtils.addLine(@state, line)
    @setState(state)

  removeLine: (index=null)->
    {history} = @state
    if not index
      history.pop()
    else
      # pluck?/splice
    @setState({history})

  onCommand: (commandData)->
    {command, args} = commandData
    @props.onCommand?(command)
    commandFunc = @props.commands[command]
    if commandFunc
      commandFunc = commandFunc.bind(@actions)
      state = commandFunc(state, args...)
    else
      # TODO: handle error
      state = @onCommandError(command)
    @setState(state)

  onCommandError: (command)->
    inputUtils.addLine(@state, "Invalid command '#{command}'", null, "red")

  onKeyDown: (event)=>
    # Key down listens for cursor movement + enter key
    state = inputUtils.reduceKeyDown(@state, event)
    @setState(state)
    if state.command
      # a command was attempted (enter key presesed)
      @onCommand(state.command)

  onKeyPress: (event)=>
    # Key press is a typed character
    state = inputUtils.reduceKeyPress(@state, event)
    @setState(state)

  render: ->
    <Terminal {...@state} />

module.exports = TerminalContainer
