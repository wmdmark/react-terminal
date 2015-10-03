require("expose?React!react");
require("expose?_!lodash");

Terminal = require("./components/Terminal")
App = React.createClass
  
  render: ->
    <div>
      <h1>Herro</h1>
      <Terminal />
    </div>

React.render(<App/>, document.getElementById('app'))