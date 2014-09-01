SmsView = null

module.exports =

module.exports =
  configDefaults:
    accountSid: ''
    authToken: ''
    from: ''

  activate: ->
    atom.workspaceView.command 'sms:open', ->
      SmsView ?= require './sms-view'
      new SmsView()
