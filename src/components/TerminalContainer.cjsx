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

  onCommand: (commandData)->
    {command, args} = commandData
    @props.onCommand?(command)
    if @props.commands[command]?
      result = @props.commands[command](@state, args...)
      console.log "command result: ", result
      state = _.extend {}, @state, result
    else
      # TODO: handle error
      @onCommandError(command)
    @setState(state)

  onCommandError: (command)->
    console.log command

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
