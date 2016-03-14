window.$ = window.jQuery = require('../node_modules/jquery')
spotyWebPaneView = require './syotify-view'


{CompositeDisposable} = require 'atom'

module.exports = spotyWebPane =
  spotyWebPaneView: null
  modalPanel: null
  subscriptions: null
  enlarged : false

  activate: (state) ->
    @spotyWebPaneView = new spotyWebPaneView(state.spotyWebPaneViewState)
    @modalPanel = atom.workspace.addRightPanel(item: @spotyWebPaneView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'syotify:toggle': => @toggle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'syotify:enlarge': => @enlarge()

    $(document).ready ->
      height = $(window).height()
      console.log height
      width = $(window).width()
      $('.spotyWeb').width(width / 3)
      $('.spotyWeb').append('<webview id="syotify" src="https:/www.listenvideo.com/" style="display:inline-block; float: right; width:' + width / 3 +'px; height:' + height + 'px;"></webview>')
      $(window).on 'resize' , ->
        height = $(window).height()
        width = $(window).width()
        $('.spotyWeb').width(width / 3)
        $('.spotyWeb').height(height)
        $('#syotify').width(width / 3)
        $('#syotify').height(height)



  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @spotyWebPaneView.destroy()

  serialize: ->
    spotyWebPaneViewState: @spotyWebPaneView.serialize()

  toggle: ->
    console.log 'spotyWebPane was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

  enlarge: ->
    if @enlarged == false
      $('#syotify').width($(window).width() / 2)
      $('.spotyWeb').width($(window).width() / 2)
      @enlarged = true
    else
      $('#syotify').width($(window).width() / 3)
      $('.spotyWeb').width($(window).width() / 3)
      @enlarged = false
