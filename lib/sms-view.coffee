{EditorView, View} = require 'atom'

module.exports =
class SmsView extends View
  @content: ->
    @div class: "sms overlay from-top", =>
      @subview "phoneNumber", new EditorView(mini: true), outlet: "phoneNumber"
      @subview "message", new EditorView(mini: true), outlet: "message"
      @div class: "text-subtle", "0/160", outlet: "count"

  initialize: ->
    @init()
    @on "sms:send", => @send()
    @on "sms:cancel", => @cancel()
    @phoneNumber.setPlaceholderText "Phone Number"
    @message.setPlaceholderText "Message"
    @message.on "keydown, keyup", =>
      @count.text "#{@message.getText().length}/160"

  destroy: ->
    @detach()

  init: ->
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
      @phoneNumber.focus()
      @phoneNumber.scrollToCursorPosition()

  send: ->
    console.log @phoneNumber.getText(), @message.getText()

  cancel: ->
    if @hasParent()
      @detach()
