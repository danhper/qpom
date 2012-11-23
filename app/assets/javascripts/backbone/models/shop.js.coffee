class Qpom.Models.Shop extends Backbone.Model
  paramRoot: 'shop'

  add_to_my_shops:(options = {}) ->
    options.url = Routes.add_to_my_shop_path(@get 'id')
    Backbone.sync.call(this, 'create', this, options)


class Qpom.Collections.ShopsCollection extends Backbone.Collection
  model: Qpom.Models.Shop
  url: '/shops'
