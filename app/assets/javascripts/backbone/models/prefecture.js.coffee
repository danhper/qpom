class Qpom.Models.Prefecture extends Backbone.Model
  paramRoot: 'prefecture'


class Qpom.Collections.PrefecturesCollection extends Backbone.Collection
  model: Qpom.Models.Prefecture
  url: '/prefectures'
  fetchWithId: (area_id, options) -> this.fetch _.extend({ data : {area_id: area_id} }, options)
