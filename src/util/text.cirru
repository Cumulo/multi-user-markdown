
var
  ({}~ recur) $ require :tail-call/core

var countHeadMatch $ recur $ \ (prevText text count)
  var firstPrevChar $ prevText.substring 0 1
  var firstChar $ text.substring 0 1
  var restPrevText $ prevText.substring 1
  var restText $ text.substring 1
  case true
    (is prevText.length 0) count
    (is text.length 0) count
    (isnt firstPrevChar firstChar) count
    else $ countHeadMatch restPrevText restText (+ count 1)

var countTailMatch $ recur $ \ (prevText text count)
  var lastPrevChar $ prevText.substr -1
  var lastChar $ text.substr -1
  var initPrevText $ prevText.substring 0 $ - prevText.length 1
  var initText $ text.substring 0 $ - text.length 1
  case true
    (is prevText.length 0) count
    (is text.length 0) count
    (isnt lastPrevChar lastChar) count
    else $ countTailMatch initPrevText initText (+ count 1)

= exports.diff $ \ (prevText text)
  var countHead $ countHeadMatch prevText text 0
  var countTail $ countTailMatch
    prevText.substring countHead
    text.substring countHead
    , 0
  var textBefore $ prevText.substring 0 countHead
  var textPrevBetween $ prevText.substring countHead
    - prevText.length countTail
  var textBetween $ text.substring countHead
    - text.length countTail
  var result $ {}
    :from textBefore.length
    :length textPrevBetween.length
    :chunk textBetween
  -- console.log :diff prevText text result
  return result

= exports.patch $ \ (text info)
  var textBefore $ text.substring 0 info.from
  var textAfter $ text.substring $ + info.from info.length
  var result $ + textBefore info.chunk textAfter
  -- console.log :patch text info result
  return result