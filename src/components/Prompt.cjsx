inputUtils = require("../data/input-reducers")

Prompt = (props)->
  [left, cursor, right] = inputUtils.getPromptStrings(
    props.input,
    props.cursorPosition
  )
  <div className="Prompt">
    <span className="Prompt__from">{props.prompt}</span>
    <span>{left}</span>
    <span className="Prompt__cursor">{cursor}</span>
    <span>{right}</span>
  </div>

Prompt.displayName = "Prompt"

module.exports = Prompt
