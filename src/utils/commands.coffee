module.exports =
  
  execute: (command, history)->
    console.log "execute", command
    if not @[command]?
      history.push(input: "Invalid command \"#{command}\"", error: yes)
    else
      history = @[command](history)
    history
  
  clear: ->
    history = []
    return history
