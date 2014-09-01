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
    @subscribe @message.getEditor().getBuffer(), "contents-modified", @updateCharacterCount

  destroy: ->
    @detach()

  init: ->
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
      @phoneNumber.focus()
      @phoneNumber.scrollToCursorPosition()

  updateCharacterCount: =>
    @count.text "#{@message.getText().length}/160"

  send: ->
    console.log @phoneNumber.getText(), @message.getText()

  cancel: ->
    if @hasParent()
      @detach()
