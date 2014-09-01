{EditorView, View} = require "atom"
client = require("twilio")(atom.config.get("sms.accountSid"), atom.config.get("sms.authToken"))

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
    atom.workspaceView.on 'focusout', '.editor:not(.mini)', => @cancel()
    atom.workspaceView.on 'pane:before-item-destroyed', => @cancel()

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

  send: =>
    client.messages.create
      from: atom.config.get("sms.from")
      to: @phoneNumber.getText()
      body: @message.getText()
    , (err) =>
      if err
        console.log err.message
      else
        @cancel()
      return

  cancel: ->
    if @hasParent()
      @detach()
