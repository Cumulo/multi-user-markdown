
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

  :componentDidUpdate $ \ ()
    this.ensureSelection

  :getText $ \ ()
    cond
      > (this.props.userState.get :time) this.state.stateTime
      ... this.props.userState
        get :lines
        join ":\n"
      , this.state.text

  :getEnd $ \ ()
    cond
      > (this.props.userState.get :time) this.state.stateTime
      this.props.userState.get :end
      , this.state.end

  :getStart $ \ ()
    cond
      > (this.props.userState.get :time) this.state.stateTime
      this.props.userState.get :start
      , this.state.start

  :ensureSelection $ \ ()
    var start (this.getStart)
    var end (this.getEnd)
    var el $ this.refs.source.getDOMNode
    console.log :ensureSelection start end
    if (isnt el.selectionStart start) $ do
      = el.selectionStart start
    if (isnt el.selectionEnd end) $ do
      = el.selectionEnd end
    return

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
        :ref :source
        :className :source
        :value text
        :onChange this.onChange
      div ({} (:className :markdown))
        MarkedReact text
