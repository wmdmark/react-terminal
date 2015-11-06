Line = require("./Line")
Prompt = require("./Prompt")

require("./style/Terminal.scss")

class Terminal extends React.Component

  componentDidUpdate: ->
    @setScrollPosition()

  setScrollPosition: ->
    node = ReactDOM.findDOMNode(@)
    offset = node.scrollHeight - node.offsetHeight
    if offset > 0
      node.scrollTop = offset

  render: ->
    {input, cursorPosition, lines, prompt, allowInput} = @props
    <div className="Terminal">
      {
        lines.map (line, index)->
          <Line key={index} {...line} />
      }
      {
        if prompt
          <Prompt prompt={prompt} input={input} cursorPosition={cursorPosition} />
      }
    </div>

module.exports = Terminal
