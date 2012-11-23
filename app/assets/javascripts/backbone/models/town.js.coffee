class Qpom.Models.Town extends Backbone.Model
  paramRoot: 'town'


class Qpom.Collections.TownsCollection extends Backbone.Collection
  model: Qpom.Models.Town
  url: '/towns'
  fetchWithId: (prefecture_id, options) -> 
    this.fetch _.extend({ data : { prefecture_id: prefecture_id } }, options)
