
var
  shortid $ require :shortid
  Immutable $ require :immutable

var
  textUtil $ require :../../util/text
  timeUtil $ require :../../util/time

= exports.replace $ \ (db action)
  console.log :editing action
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
              cond (> start (+ info.start info.length)) (+ start info.length)
                cond (> start info.start) info.start start
            update :end $ \ (end)
              cond (> end (+ info.start info.length)) (+ end info.length)
                cond (> end info.start) info.start end
