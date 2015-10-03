ContentEditable = React.createClass

  render: ->
    <div id="contenteditable"
      style={border: "1px solid red"}
      onInput={@emitChange} 
      onBlur={@emitChange}
      onKeyDown={@props.onKeyDown}
      contentEditable
      dangerouslySetInnerHTML={{__html: @props.html}}></div>
  
  shouldComponentUpdate: (nextProps)->
    nextProps.html isnt @getDOMNode().innerHTML

  componentDidUpdate: ()->
    if @props.html isnt @getDOMNode().innerHTML
       @getDOMNode().innerHTML = @props.html

  emitChange: (evt)->
    html = @getDOMNode().innerHTML
    if @props.onChange && html isnt @lastHtml
      evt.target = { value: html }
      @props.onChange(evt)
    @lastHtml = html

module.exports = ContentEditable