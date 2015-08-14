
var
  diff $ require :immutablediff
  Pipeline $ require :cumulo-pipeline
  Immutable $ require :immutable

= exports.in $ new Pipeline
= exports.out $ new Pipeline

var expand
= exports.setup $ \ (options)
  = expand options.expand

var _cache $ Immutable.fromJS $ {}

exports.in.for $ \ (db)
  ... db (getIn $ [] :states) $ forEach $ \ (aState)
    var theCache $ or
      _cache.get (state.get :id)
      Immutable.Map
    if
      or
        isnt (theCache.get :db) db
        isnt (theCache.get :state) aState
      do
        var newTree $ expand db aState
        var oldTree $ or
          theCache.get :tree
          Immutable.Map
        exports.send $ {}
          :id $ state.get :id
          :diff $ diff oldTree newTree
        = _cache $ _cache.set (state.get :id) $ ... theCache
          set :db db
          set :state aState
          set :tree newTree
    return true
