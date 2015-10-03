ContentEditable = require("./ContentEditable")

Terminal = React.createClass
  
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