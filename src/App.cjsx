require("expose?React!react");
require("expose?_!lodash");

ReactDOM = require("react-dom")

TerminalContainer = require("./components/TerminalContainer")

state =
  history: []
  cursorPosition: 0
  input: ""
  prompt: "~/ » "

commands =

  clear: (state)->
    state = _.extend {}, state,
      history: []
      cursorPosition: 0
      input: ""
    return state

  echo: (state, input)->
    {history} = state
    history.push({input, prompt: state.prompt})
    state = _.extend {}, state,
      history: history
      cursorPosition: 0
      input: ""
    return state

  su: (state, user)->
    state = _.extend {}, state,
      prompt: "#{user}@~/ » "
    return state

  error: (state, command)->
    return @echo("Command '#{}' not found.")


App = ->
  <TerminalContainer state={state} commands={commands} />

React.render(<App/>, document.getElementById('app'))
