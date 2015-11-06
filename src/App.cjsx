require("expose?React!react");
require("expose?ReactDOM!react-dom");
require("expose?_!lodash");

TerminalContainer = require("./components/TerminalContainer")

App = ->
  <TerminalContainer />

ReactDOM.render(<App/>, document.getElementById('app'))
