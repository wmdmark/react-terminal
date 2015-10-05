ContentEditable = require("./ContentEditable")


Line = React.createClass

  render: ->
    {prefix, input, prompt} = @props
    <div className="line">
      {
        if prefix
          <span className="prefix">{prefix}</span>
      }
      <span className="input">{input}</span>
      {
        if prompt
          <span className="prompt"> </span>
      }
    </div>

LineTyper = React.createClass

  displayName: "LineTyper"

  getDefaultProps: ->
    charDelay: 100

  getInitialState: ->
    charPosition: 0

  componentDidMount: ->
    @timer = setInterval(@type, @props.charDelay)

  componentWillUnmount: ->
    clearInterval(@timer)

  type: ->
    char = @props.line[char]


Terminal = React.createClass

  displayName: "Terminal"

  render: ->
    <div className="Terminal">
      { @props.history.map (line)-> <Line {...line} /> }
    </div>

CommandTerminal = React.createClass

  getInitialState: ->
    history: []
    history_pos: 0
    input: ""

  onChange: (e)->
    @setState(input: e.target.value)

  onKeyDown: (e)->
    {history, input, history_pos} = @state
    switch e.keyCode
      when 13 # enter
        history.push(@state.input)
        input = ""
        @setState({input, history})
      when 38 # up arrow
        input = history.pop()
        @setState({input, history})
      when 40 # down arrow
        input = history.shift()
        @setState({input, history})

  render: ->
    prompt = "Enter a command"
    <div>
      {@state.history.map (line)-> <div>{line}</div>}
      <div className="prompt">
        {prompt}
        <div className="cmd">
          <span class="prompt"><span>
          </span></span>
          <span>TESADFASFDSADFSFSAD</span>
          <span class="cursor">F</span>
          <span>ASFDASDF</span>
          <textarea class="clipboard"></textarea></div>
      </div>
    </div>

module.exports = Terminal
