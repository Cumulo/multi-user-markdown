
var
  React $ require :react
  Pipeline $ require :cumulo-pipeline

-- ":marked-react problem"
= window.React React

var
  view $ require :../frontend/view
  schema $ require :../backend/schema

var
  Editor $ React.createFactory $ require :./editor

= exports.in $ new Pipeline

var
  div $ React.createFactory :div

var pageComponent $ React.createClass $ {}
  :displayName :app-page

  :getInitialState $ \ ()
    {} (:store schema.store)

  :componentWillMount $ \ ()
    exports.in.for $ \\ (store)
      this.setState $ {} (:store store)

  :render $ \ ()
    div ({} (:className :app-page))
      Editor $ {}
        :userState this.state.store

var Page $ React.createFactory pageComponent

React.render (Page) document.body
