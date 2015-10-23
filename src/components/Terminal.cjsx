Line = require("./Line")
Prompt = require("./Prompt")

require("./style/Terminal.css")

Terminal = (props)->
  {input, cursorPosition, history, prompt} = props
  <div className="Terminal">
    { history.map (line, index)-> <Line key={index} line={line} /> }
    { 
      if prompt?
        <Prompt prompt={prompt} input={input} cursorPosition={cursorPosition} />
    }
  </div>

Terminal.displayName = "Terminal"

module.exports = Terminal