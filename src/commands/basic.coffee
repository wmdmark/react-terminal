path = require("path")
Remarkable = require("remarkable")
md = new Remarkable()

help = (state)->
  {buffer} = state
  for key, val of @
    if val.help
      help = "**#{key}**: #{val.help}"
      rendered = md.render(help).replace("<p>", "").replace("</p>", "")
      buffer.push({input: rendered, type: "html"})
  {buffer}
help.help = "You're looking at it!"

clear = (state)->
  lines: []
  cursorPosition: 0
  input: ""
clear.help = "Clears the terminal."

echo = (state, args...)->
  output = args.join(" ")
  state.buffer.push(output)
  {buffer: state.buffer}

su = (state, user)->
  prompt: "#{user}@~/ » "
su.help = "Switch users. Example: _su wmdmark_"

module.exports = {help, clear, echo, su}
