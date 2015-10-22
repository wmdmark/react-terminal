require("expose?React!react");
require("expose?_!lodash");

Terminal = require("./components/Terminal")
require("./components/style/Terminal.css")

ReactDOM = require("react-dom")

App = React.createClass

  render: ->
    <div>
      <h1>Demo</h1>
      <Terminal />
    </div>

React.render(<App/>, document.getElementById('app'))
