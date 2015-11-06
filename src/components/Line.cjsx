Line = (props)->
  {input, prompt, color, type} = props
  style = if color
    {color}
  else
    {}

  if type is "html"
    input = <span dangerouslySetInnerHTML={__html: input}/>

  <div className="Line">
    <span className="Line__prompt">{prompt}</span>
    <span className="Line__input" style={style}>{input}</span>
  </div>

Line.displayName = "Line"

module.exports = Line
