require("expose?React!react");

ReactDOM = require("react-dom")

TerminalContainer = require("./components/TerminalContainer")

state = 
  history: []
  cursorPosition: 0
  input: ""
  prompt: "~ » "

App = ->
  <TerminalContainer initialState={state} />

React.render(<App/>, document.getElementById('app'))
