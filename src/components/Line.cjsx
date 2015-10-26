Line = (props)->
  {input, prompt, color} = props
  style = if color
    {color}
  else
    {}
  <div className="Line">
    <span className="Line__prompt">{prompt}</span>
    <span className="Line__input" style={style}>{input}</span>
  </div>

Line.displayName = "Line"

module.exports = Line
