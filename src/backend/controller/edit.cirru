
var
  shortid $ require :shortid
  Immutable $ require :immutable

= exports.replace $ \ (db action)
  console.log :editing action
  return db
