Line = (props)->
  {line, color, delay} = props
  className = "Line"
  style = if color
    {color}
  else
    {}
  <div className={className}>
    <span className="Line__prompt">{line.prompt}</span>
    <span className="Line__input" style={style}>{line.input}</span>
  </div>

Line.displayName = "Line"

module.exports = Line