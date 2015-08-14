
var
  Pipeline $ require :cumulo-pipeline

var
  schema $ require :./schema
  editController $ require :./controller/edit
  stateController $ require :./controller/state

= exports.in $ new Pipeline

var _database schema.database

= exports.out $ exports.in.reduce _database $ \ (db action)
  case action.type
    :edit/replace $ editController.replace db action
    :state/connect $ stateController.connect db action
    :state/disconnect $ stateController.disconnect db action
    else db
