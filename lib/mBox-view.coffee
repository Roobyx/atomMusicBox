{View} = require '../node_modules/atom-space-pen-views'

module.exports =
class mBoxWebPaneView extends View
  @content: ->
    @div class:'pane-item native-key-bindings' , =>
      @div class: 'mBoxViewer'

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
