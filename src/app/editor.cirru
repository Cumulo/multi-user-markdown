
var
  React $ require :react
  Immutable $ require :immutable

var
  timeUtil $ require :../util/time

var
  MarkedReact $ React.createFactory $ require :marked

var
  div $ React.createFactory :div

= modue.exports $ React.createClass $ {}
  :displayName :app-editor

  :propTypes $ {}
    :userState $ React.PropTypes.instanceOf Immutable.Map

  :getInitialState $ \ ()
    var text $ this.props.userState.get :text
    {}
      :stateTime (timeUtil.getNowString)
      :text text
      :start text.length
      :end text.length

  :onChange $ \ (event)
    this.setState $ {}
      :text event.target.value
      :stateTime (timeUtil.getNowString)
      :start event.target.selectionStart
      :end event.target.selectionEnd

  :render $ \ ()
    var userState $ cond
      > (this.props.userState.get :stateTime) (this.state.stateTime)
      , (this.props.userState.toJS) this.state

    div ({} (:className :app-editor))
      textarea $ {} (:value userState.text) (:onChange this.onChange)
      MarkedReact userState.text
