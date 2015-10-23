Line = (props)->
  {line} = props
  <div className="Line">
    <span className="Line__prompt">{line.prompt}</span>
    <span className="Line__input">{line.input}</span>
  </div>

Line.displayName = "Line"

module.exports = Line