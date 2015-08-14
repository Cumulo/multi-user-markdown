
var
  Pipeline $ require :cumulo-pipeline

var
  schema $ require :./schema
  editController $ require :./controller/edit

= exports.in $ new Pipeline

var _database schema.database

= exports.out $ exports.in.reduce _database $ \ (db action)
  var stateId action.stateId
  case action.type
    :replace $ editController.replace db action
    else db
