Prompt = (props)->
  {input, prompt, cursorPosition} = props
  cursor = if cursorPosition < (input.length)
    input[cursorPosition]
  else
    "\u00a0"
  <div className="Prompt">
    <span className="Prompt__from">{prompt}</span>
    <span>{input.substring(0, cursorPosition)}</span>
    <span className="Prompt__cursor">{cursor}</span>
    <span>{input.substring(cursorPosition+1, input.length)}</span>
  </div>

Prompt.displayName = "Prompt"

module.exports = Prompt