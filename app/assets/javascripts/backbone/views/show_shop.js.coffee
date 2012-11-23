class Qpom.Views.ShowShopView extends Backbone.View
  el: '.ui-content'

  events: 'click #register': 'add_my_shop'

  add_my_shop: ->
    @model.add_to_my_shops()
