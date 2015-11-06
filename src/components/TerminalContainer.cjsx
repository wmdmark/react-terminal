inputReducers = require("../data/input-reducers")
Terminal = require("./Terminal")

class TerminalContainer extends React.Component

  componentWillMount: ->
    @state =
      recording: no
      playing: no
      lines: [] # lines shown
      history: [] # commands executed
      input: "" # user input
      cursorPosition: 0 # the position of the input cursor
      recordStartTime: null
      buffer: [] # queued lines
      prompt: ">> "
      historyScrollOffset: 0
    if @props.initialState
      _.assign @state, @props.initialState

  componentDidMount: ->
    document.addEventListener("keydown", @keyHandler)
    document.addEventListener("keypress", @keyHandler)
    if @state.buffer.length
      @buffer()

  componentWillUnmount: ->
    document.removeEventListener("keydown", @keyHandler)
    document.removeEventListener("keypress", @keyHandler)

  keyHandler: (event)=>
    if event.ctrlKey and event.keyCode is 67
      @bufferCanceled = yes
    if not @state.playing
      updates = inputReducers.reduceKey(@state, event)
      if updates
        event.preventDefault()
        state = _.assign {}, @state, updates
        @setState(state)

  shouldComponentUpdate: (prevState, nextState)->
    return prevState isnt nextState

  componentDidUpdate: ->
    @buffer()


  buffer: ->
    if @state.buffer.length
      inputReducers.reduceBuffer(@state)
        .then (nextState)=>
          # Make sure the buffer wasn't canceled before promise resolved...
          if not @bufferCanceled
            @setState(nextState)
          else
            # Buffer was cancled mid-stream... gotta clear it
            @bufferCanceled = no
            nextState = inputReducers.clearBuffer(@state)
            console.log "cleared buffer: ", nextState.lines
            @setState(nextState)
        .catch (err)=>
          console.error(err)
          @setState(inputReducers.reduceError(@state, err))
    else
      # have to stop playing
      if @state.playing
        @setState(_.assign {}, {playing: no})

  render: ->
    window.state = @state
    <Terminal {...@state} />

module.exports = TerminalContainer
