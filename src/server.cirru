
var
  robot $ require :./backend/robot
  expand $ require :./backend/expand
  differ $ require :./backend/differ
  database $ require :./backend/database
  websocket $ require :./backend/websocket

websocket.setup $ {} (:port 4001)
-- websocket.out.for $ \ (data)
  console.log :websocket.out $ JSON.stringify data

differ.setup $ {} (:expand expand)

websocket.out.forward database.in
database.out.forward differ.in
differ.out.forward websocket.in

database.out.for $ \ (data)
  console.log :database.out $ JSON.stringify data

-- robot.out.forward database.in
