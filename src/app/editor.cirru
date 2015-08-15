
var
  React $ require :react
  Immutable $ require :immutable
  MarkedReact $ require :marked

var
  view $ require :../frontend/view
  text $ require :../util/text
  timeUtil $ require :../util/time

var
  div $ React.createFactory :div
  textarea $ React.createFactory :textarea

MarkedReact.setOptions $ {}
  :gfm true
  :breaks true

= module.exports $ React.createClass $ {}
  :displayName :app-editor

  :propTypes $ {}
    :userState $ React.PropTypes.instanceOf Immutable.Map

  :getInitialState $ \ ()
    var text $ ... this.props.userState
      get :lines
      join ":\n"
    {}
      :stateTime (timeUtil.getPast)
      :text text
      :start text.length
      :end text.length

  :getText $ \ ()
    cond
      > (this.props.userState.get :time) this.state.stateTime
      ... this.props.userState
        get :lines
        join ":\n"
      , this.state.text

  :onChange $ \ (event)
    var info $ text.diff (this.getText) event.target.value
    = info.start event.target.selectionStart
    = info.end event.target.selectionEnd
    view.action $ {}
      :type :edit/replace
      :data info

    this.setState $ {}
      :text event.target.value
      :stateTime (timeUtil.getNowString)
      :start event.target.selectionStart
      :end event.target.selectionEnd

  :render $ \ ()
    var text (this.getText)

    div ({} (:className :app-editor))
      textarea $ {}
        :className :source
        :value text
        :onChange this.onChange
      div ({} (:className :markdown))
        MarkedReact text
