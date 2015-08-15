
var
  Pipeline $ require :cumulo-pipeline

= exports.out $ new Pipeline

setInterval
  \ ()
    exports.out.send $ {}
      :type :edit/replace
      :stateId :robot
      :data $ {}
        :from 0
        :length 0
        :chunk :x
  , 2000
