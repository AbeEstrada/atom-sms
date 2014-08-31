SmsView = null

module.exports =

  activate: ->
    atom.workspaceView.command 'sms:open', ->
      SmsView ?= require './sms-view'
      new SmsView()
