class Qpom.Views.AppView extends Backbone.View
  el: 'body'

  initialize: ->
    @$el.on 'click', '#menu-button', => @$('#top-menu').toggle()
  
