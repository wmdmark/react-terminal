Line = (props)->
  console.log "render line", props.line
  {line} = props
  className = "Line"
  if line.error is yes
    className = "#{className} error"
  <div className={className}>
    <span className="Line__prompt">{line.prompt}</span>
    <span className="Line__input">{line.input}</span>
  </div>

Line.displayName = "Line"

module.exports = Line