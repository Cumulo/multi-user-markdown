
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
      :stateTime (timeUtil.getNowString)
      :text text
      :start text.length
      :end text.length

  :onChange $ \ (event)
    console.log $ text.diff this.state.text event.target.value
    this.setState $ {}
      :text event.target.value
      :stateTime (timeUtil.getNowString)
      :start event.target.selectionStart
      :end event.target.selectionEnd

  :render $ \ ()
    var userState $ cond
      > (this.props.userState.get :time) this.state.stateTime
      , (this.props.userState.toJS) this.state

    div ({} (:className :app-editor))
      textarea $ {}
        :className :source
        :value userState.text
        :onChange this.onChange
      div ({} (:className :markdown))
        MarkedReact userState.text
