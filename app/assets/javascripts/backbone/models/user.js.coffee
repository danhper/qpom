class Qpom.Models.User extends Backbone.Model
  paramRoot: 'user'


class Qpom.Collections.UsersCollection extends Backbone.Collection
  model: Qpom.Models.User
  url: '/users'
