
var
  Immutable $ require :immutable

var
  schema $ require :./schema

= module.exports $ \ (db state)
  ... schema.store
    setIn ([] :context :lines)
      Immutable.fromJS $ ... db
        getIn ([] :context :text)
        split ":\n"
    setIn ([] :state :start) $ state.get :start
    setIn ([] :state :end) $ state.get :end
