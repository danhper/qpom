class Qpom.Views.AppView extends Backbone.View
  el: 'body'

  events:
    'click #menu-button': 'toggleMenu'
  
  toggleMenu: (e) ->
    $('#top-menu').toggle();
