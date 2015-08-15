
var
  expand $ require :./backend/expand
  differ $ require :./backend/differ
  database $ require :./backend/database
  websocket $ require :./backend/websocket

websocket.setup $ {} (:port 3000)
-- websocket.out.for $ \ (data)
  console.log :websocket.out data

differ.setup $ {} (:expand expand)

websocket.out.forward database.in
database.out.forward differ.in
differ.out.forward websocket.in
