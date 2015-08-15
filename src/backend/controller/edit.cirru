
var
  shortid $ require :shortid
  Immutable $ require :immutable

var
  monad $ require :../../util/monad
  textUtil $ require :../../util/text
  timeUtil $ require :../../util/time

= exports.replace $ \ (db action)
  console.log :editing $ JSON.stringify action
  var
    stateId action.stateId
    info action.data
  ... db
    updateIn ([] :context :text) $ \ (text)
      textUtil.patch text info
    setIn ([] :context :time) (timeUtil.getNowString)
    update :states $ \ (states)
      states.map $ \ (aState)
        cond (is (aState.get :id) stateId)
          ... aState (set :start info.start) (set :end info.end)
          ... aState
            update :start $ \ (start)
              cond
                > start (+ info.from info.length)
                + start info.chunk.length
                cond (> start info.from) info.from start
            update :end $ \ (end)
              cond
                > end (+ info.from info.length)
                + end info.chunk.length
                cond (> end info.from) info.from end
