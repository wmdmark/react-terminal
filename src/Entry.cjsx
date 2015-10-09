require("expose?React!react");
require("expose?_!lodash");

session = {}
saveName = (name)->
  session.name = name

script = [
  {actor: "<wmdmark>", line: "Hello friend. If you've come, you've come for a reason. You may not be able to explain it yet, but there's a part of you that's exhausted with this world... a world that decides where you work, who you see, and how you empty and fill your depressing bank account. Even the Internet connection you're using to read this is costing you, slowly chipping away at your existence. There are things you want to say. Soon I will give you a voice. Today your education begins."},
  {actor: "<wmdmark>", line: "Now let's get to know you. What is you hacker name?"},
  {prompt: "Enter your hacker name", action: saveName},
  {actor: "<wmdmark>", line: "Welcome {name}, let's get started"},
]

TerminalScript = React.createClass

  getInitialState: ->
    lines: []
    scriptPos: 0

  nextLine: ->
    {scriptPos, lines} = @state
    lines.push(@props.script[])

  render: ->
    <Terminal history={@state.lines} onLineChange={@nextLine} />


Terminal = require("./components/Terminal")
App = React.createClass

  render: ->
    <div>
      <Terminal />
    </div>

React.render(<App/>, document.getElementById('app'))
