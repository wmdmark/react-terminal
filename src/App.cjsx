require("expose?React!react");

ReactDOM = require("react-dom")

TerminalContainer = require("./components/TerminalContainer")

state = 
  history: []
  cursorPosition: 0
  input: ""
  prompt: "~/ » "

App = ->
  <TerminalContainer state={state} />

React.render(<App/>, document.getElementById('app'))
