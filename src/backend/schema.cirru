
var
  Immutable $ require :immutable

var
  timeUtil $ require :../util/time

= exports.database $ Immutable.fromJS $ {}
  :context $ {}
    :text :
    :time (timeUtil.getNowString)
  :states $ {}

= exports.state $ Immutable.fromJS $ {}
  :id null
  :start 0
  :end 0

= exports.store $ Immutable.fromJS $ {}
  :context $ {}
    :lines $ []
    :time (timeUtil.getNowString)
  :state $ {}
    :start 0
    :end 0
