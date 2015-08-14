
var
  Pipeline $ require :cumulo-pipeline

var
  page $ require :./app/page
  view $ require :./frontend/view
  store $ require :./frontend/store
  websocket $ require :./frontend/websocket

require :origami-ui

websocket.out.forward store.in
store.out.forward page.in
view.out.forward websocket.in

websocket.setup $ {} (:port 3000)

store.out.for $ \ (data)
  console.info (data.toJS)
