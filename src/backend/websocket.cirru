
var
  ws $ require :ws
  shortid $ require :shortid
  Pipeline $ require :cumulo-pipeline

= exports.in $ new Pipeline
= exports.out $ new Pipeline

var register $ {}

var connectionHandler $ \ (socket)
  var id (shortid.generate)
  = (. register id) socket

  socket.on :close $ \ ()
    = (. register id) null
    exports.out.send $ {}
      :type :state/disconnect
      :stateId id

  socket.on :message $ \ (rawData)
    var action $ JSON.parse rawData
    = action.stateId id
    exports.out.send action

  exports.out.send $ {}
    :type :state/connect
    :stateId id

= exports.setup $ \ (options)
  var wss $ new ws.Server $ {} (:port options.port)
  wss.on :connection connectionHandler
  console.log ":ws server listening at" options.port

exports.in.for $ \ (op)
  var socket $ . register op.id
  if (? socket)
    do $ socket.send $ JSON.stringify op.diff
    do $ console.warn ":missing socket" op
  return
