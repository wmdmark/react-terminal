require("expose?React!react");
require("expose?_!lodash");

ReactDOM = require("react-dom")

inputUtils = require("./utils/input-utils")
TerminalContainer = require("./components/TerminalContainer")

state =
  history: []
  cursorPosition: 0
  input: ""
  prompt: "~/ » "

class Loader extends React.Component

  componentWillMount: ->
    @state = index: 0
    @timer = setInterval @tick, 300

  compontentWillUnmount: ->
    clearInterval(@timer)

  tick: =>
    index = if @state.index < 2
      @state.index+1
    else
      0
    @setState({index: index})

  render: ->
    char = ["/", "--", "\\"][@state.index]
    <span style={color: "#fff"}>{char}</span>



commands =

  clear: (state)->
    history: []
    cursorPosition: 0
    input: ""

  echo: (state, args...)->
    console.log "echo", state, args, @
    output = args.join(" ")
    @addLine(output)

  su: (state, user)->
    prompt: "#{user}@~/ » "

  error: (state, command)->
    output = "Command '#{command}' not found."
    inputUtils.addLine(state, output)

  load: (connector)->
    connector.addLine(state, <Loader />)
    _.delay ->
      connector.addLine(state, "Finished!")
    , 2000
    {}

App = ->
  <TerminalContainer state={state} commands={commands} />

React.render(<App/>, document.getElementById('app'))
