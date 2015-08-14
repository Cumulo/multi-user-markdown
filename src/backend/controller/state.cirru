
var
  Immutable $ require :immutable

var
  schema $ require :../schema

= exports.connect $ \ (db action)
  ... db
    setIn ([] :states action.stateId)
      schema.state.merge $ Immutable.fromJS $ {}
        :id action.stateId

= exports.disconnect $ \ (db action)
  ... db
    deleteIn ([] :states action.stateId)
