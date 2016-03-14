window.$ = window.jQuery = require('../node_modules/jquery')
mBoxWebPaneView = require './mBox-view'


{CompositeDisposable} = require 'atom'

module.exports = mBoxViewerPane =
  mBoxWebPaneView: null
  modalPanel: null
  subscriptions: null
  enlarged : false

  activate: (state) ->
    @mBoxWebPaneView = new mBoxWebPaneView(state.mBoxWebPaneViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @mBoxWebPaneView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'mBox:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mBox:enlarge': => @enlarge()

    $(document).ready ->
      height = $(window).height()
      console.log height
      width = $(window).width()
      $('.mBoxViewer').width(width / 3)
      $('.mBoxViewer').append('<webview id="mBox" src="https:/www.listenvideo.com/" style="display:inline-block; float: right; width:' + width / 3 +'px; height:' + height + 'px;"></webview>')
      $(window).on 'resize' , ->
        height = $(window).height()
        width = $(window).width()
        $('.mBoxViewer').width(width / 3)
        $('.mBoxViewer').height(height)
        $('#mBox').width(width / 3)
        $('#mBox').height(height)



  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @mBoxWebPaneView.destroy()

  serialize: ->
    mBoxWebPaneViewState: @mBoxWebPaneView.serialize()

  toggle: ->
    console.log 'mBoxViewerPane was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  enlarge: ->
    if @enlarged == false
      $('#mBox').width($(window).width() / 2)
      $('.mBoxViewer').width($(window).width() / 2)
      @enlarged = true
    else
      $('#mBox').width($(window).width() / 3)
      $('.mBoxViewer').width($(window).width() / 3)
      @enlarged = false
