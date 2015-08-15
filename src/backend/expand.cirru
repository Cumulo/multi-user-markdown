
var
  Immutable $ require :immutable

var
  schema $ require :./schema

= module.exports $ \ (db state)
  ... schema.store
    set :lines
      Immutable.fromJS $ ... db
        getIn ([] :context :text)
        split ":\n"
    set :time $ ... db (getIn $ [] :context :time)
    set :start $ state.get :start
    set :end $ state.get :end
