{EditorView, View} = require 'atom'

module.exports =
class SmsView extends View
  @content: ->
    @div class: 'sms overlay from-top', =>
      @label 'Phone Number'
      @subview 'phoneNumber', new EditorView(mini: true), outlet: 'phoneNumber'
      @label 'Message'
      @subview 'message', new EditorView(mini: true), outlet: 'message'
      @div class: 'text-subtle', '0/160', outlet: 'count'

  initialize: ->
    @attach()
    @on 'sms:send', => @send()
    @on 'sms:cancel', => @cancel()

  destroy: ->
    @detach()

  attach: ->
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
