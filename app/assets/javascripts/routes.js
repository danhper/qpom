(function(){

  function ParameterMissing(message) {
   this.message = message;
  }
  ParameterMissing.prototype = new Error(); 

  var defaults = {
    prefix: '',
    format: ''
  };

  var NodeTypes = {"GROUP":1,"CAT":2,"SYMBOL":3,"OR":4,"STAR":5,"LITERAL":6,"SLASH":7,"DOT":8}
  
  var Utils = {

    serialize: function(obj){
      if (!obj) {return '';}
      if (window.jQuery) {
        var result = window.jQuery.param(obj);
        return !result ? "" : "?" + result
      }
      var s = [];
      for (prop in obj){
        if (obj[prop]) {
          if (obj[prop] instanceof Array) {
            for (var i=0; i < obj[prop].length; i++) {
              key = prop + encodeURIComponent("[]");
              s.push(key + "=" + encodeURIComponent(obj[prop][i].toString()));
            }
          } else {
            s.push(prop + "=" + encodeURIComponent(obj[prop].toString()));
          }
        }
      }
      if (s.length === 0) {
        return '';
      }
      return "?" + s.join('&');
    },

    clean_path: function(path) {
      path = path.split("://");
      last_index = path.length - 1;
      path[last_index] = path[last_index].replace(/\/+/g, "/").replace(/\/$/m, '');
      return path.join("://");
    },

    set_default_format: function(options) {
      if (!options.hasOwnProperty("format") && defaults.format) options.format = defaults.format;
    },

    extract_anchor: function(options) {
      var anchor = options.hasOwnProperty("anchor") ? options.anchor : null;
      delete options.anchor;
      return anchor ? "#" + anchor : "";
    },

    extract_options: function(number_of_params, args) {
      if (args.length > number_of_params) {
        return typeof(args[args.length-1]) == "object" ?  args.pop() : {};
      } else {
        return {};
      }
    },

    path_identifier: function(object) {
      if (!object) {
        return "";
      }
      if (typeof(object) == "object") {
        var property = object.to_param || object.id || object;
        if (typeof(property) == "function") {
          property = property.call(object)
        }
        return property.toString();
      } else {
        return object.toString();
      }
    },

    clone: function (obj) {
      if (null == obj || "object" != typeof obj) return obj;
      var copy = obj.constructor();
      for (var attr in obj) {
        if (obj.hasOwnProperty(attr)) copy[attr] = obj[attr];
      }
      return copy;
    },

    prepare_parameters: function(required_parameters, actual_parameters, options) {
      var result = this.clone(options) || {};
      for (var i=0; i < required_parameters.length; i++) {
        result[required_parameters[i]] = actual_parameters[i];
      }
      return result;
    },

    smartIndexOf: function(array, item){
      if (Array.prototype.indexOf && array.indexOf === Array.prototype.indexOf) return array.indexOf(item);
      for (var i = 0; i < array.length; i++) if (i in array && array[i] === item) return i;
      return -1;
    },

    build_path: function(required_parameters, optional_parts, route, args) {
      args = Array.prototype.slice.call(args);
      var opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }

      parameters = this.prepare_parameters(required_parameters, args, opts);
      // Array#indexOf is not supported by IE <= 8, so we use custom method
      if (Utils.smartIndexOf(optional_parts, 'format') !== -1) {
        this.set_default_format(parameters);
      }
      var result = Utils.get_prefix();
      var anchor = Utils.extract_anchor(parameters);

      result += this.visit(route, parameters)
      return Utils.clean_path(result + anchor) + Utils.serialize(parameters);
    },

    /*
     * This function is JavaScript impelementation of the
     * Journey::Visitors::Formatter that builds route by given parameters
     * and parsed route binary tree.
     * Binary tree is serialized in the following way:
     * [node type, left node, right node ]
     */
    visit: function(route, options) {
      var type = route[0];
      var left = route[1];
      var right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return this.visit_group(left, options)
        case NodeTypes.STAR:
          return this.visit_group(left, options)
        case NodeTypes.CAT:
          return this.visit(left, options) + this.visit(right, options);
        case NodeTypes.SYMBOL:
          var value = options[left];
          if (value) {
            delete options[left];
            return this.path_identifier(value); 
          } else {
            throw new ParameterMissing("Route parameter missing: " + left);
          }
        /*
         * I don't know what is this node type
         * Please send your PR if you do
         */
        //case NodeTypes.OR:
        case NodeTypes.LITERAL:
          return left;
        case NodeTypes.SLASH:
          return left;
        case NodeTypes.DOT:
          return left;
        default:
          throw new Error("Unknown Rails node type");
      }
      
    },

    visit_group: function(left, options) {
      try {
        return this.visit(left, options);
      } catch(e) {
        if (e instanceof ParameterMissing) {
          return "";
        } else {
          throw e;
        }
      }
    },

    get_prefix: function(){
      var prefix = defaults.prefix;

      if( prefix !== "" ){
        prefix = prefix.match('\/$') ? prefix : ( prefix + '/');
      }
      
      return prefix;
    },

    namespace: function (root, namespaceString) {
        var parts = namespaceString ? namespaceString.split('.') : [];
        if (parts.length > 0) {
            current = parts.shift();
            root[current] = root[current] || {};
            Utils.namespace(root[current], parts.join('.'));
        }
    }
  };

  Utils.namespace(window, 'Routes');
  window.Routes = {
// add_to_my_shop => /shops/:id/add_to_my(.:format)
  add_to_my_shop_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"add_to_my",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_couponlist => /admin/couponlist(.:format)
  admin_couponlist_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"couponlist",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_shop => /admin/shop(.:format)
  admin_shop_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"shop",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_shoplist => /admin/shoplist(.:format)
  admin_shoplist_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"shoplist",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// admin_userlist => /admin/userlist(.:format)
  admin_userlist_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"admin",false]],[7,"/",false]],[6,"userlist",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// cancel_shop_registration => /shops/cancel(.:format)
  cancel_shop_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"cancel",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// cancel_user_registration => /users/cancel(.:format)
  cancel_user_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"cancel",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// coupons_my => /coupons/my(.:format)
  coupons_my_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"coupons",false]],[7,"/",false]],[6,"my",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// coupons_ranking => /coupons/ranking(.:format)
  coupons_ranking_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"coupons",false]],[7,"/",false]],[6,"ranking",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// destroy_shop_session => /shops/sign_out(.:format)
  destroy_shop_session_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"sign_out",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// destroy_user_session => /logout(.:format)
  destroy_user_session_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"logout",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_shop => /shops/:id/edit(.:format)
  edit_shop_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_shop_coupon => /shops/:shop_id/coupons/:id/edit(.:format)
  edit_shop_coupon_path: function(_shop_id, _id, options) {
  return Utils.build_path(["shop_id","id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"shop_id",false]],[7,"/",false]],[6,"coupons",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_shop_password => /shops/password/edit(.:format)
  edit_shop_password_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"password",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_shop_registration => /shops/edit(.:format)
  edit_shop_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_user => /users/:id/edit(.:format)
  edit_user_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_user_password => /users/password/edit(.:format)
  edit_user_password_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"password",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// edit_user_registration => /users/edit(.:format)
  edit_user_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"edit",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// find_shops => /shops/find(.:format)
  find_shops_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"find",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// my_shops => /shops/my(.:format)
  my_shops_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"my",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_shop => /shops/new(.:format)
  new_shop_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_shop_coupon => /shops/:shop_id/coupons/new(.:format)
  new_shop_coupon_path: function(_shop_id, options) {
  return Utils.build_path(["shop_id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"shop_id",false]],[7,"/",false]],[6,"coupons",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_shop_password => /shops/password/new(.:format)
  new_shop_password_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"password",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_shop_registration => /shops/register(.:format)
  new_shop_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"register",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_shop_session => /shops/login(.:format)
  new_shop_session_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"login",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_user => /users/new(.:format)
  new_user_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_user_password => /users/password/new(.:format)
  new_user_password_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"password",false]],[7,"/",false]],[6,"new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_user_registration => /users/sign_up(.:format)
  new_user_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"sign_up",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// new_user_session => /login(.:format)
  new_user_session_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"login",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// prefectures => /prefectures(.:format)
  prefectures_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"prefectures",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// rails_info_properties => /rails/info/properties(.:format)
  rails_info_properties_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"rails",false]],[7,"/",false]],[6,"info",false]],[7,"/",false]],[6,"properties",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// root => /
  root_path: function(options) {
  return Utils.build_path([], [], [7,"/",false], arguments);
  },
// search_shops => /shops/search(.:format)
  search_shops_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"search",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// share_shop_coupons => /shops/:shop_id/coupons/share(.:format)
  share_shop_coupons_path: function(_shop_id, options) {
  return Utils.build_path(["shop_id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"shop_id",false]],[7,"/",false]],[6,"coupons",false]],[7,"/",false]],[6,"share",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// shop => /shops/:id(.:format)
  shop_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// shop_coupon => /shops/:shop_id/coupons/:id(.:format)
  shop_coupon_path: function(_shop_id, _id, options) {
  return Utils.build_path(["shop_id","id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"shop_id",false]],[7,"/",false]],[6,"coupons",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// shop_coupons => /shops/:shop_id/coupons(.:format)
  shop_coupons_path: function(_shop_id, options) {
  return Utils.build_path(["shop_id"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"shop_id",false]],[7,"/",false]],[6,"coupons",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// shop_password => /shops/password(.:format)
  shop_password_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"password",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// shop_registration => /shops(.:format)
  shop_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"shops",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// shop_session => /shops/login(.:format)
  shop_session_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[6,"login",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// shops => /shops(.:format)
  shops_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"shops",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// show_new_shop_coupons => /shops/:shop_id/coupons/show_new(.:format)
  show_new_shop_coupons_path: function(_shop_id, options) {
  return Utils.build_path(["shop_id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"shop_id",false]],[7,"/",false]],[6,"coupons",false]],[7,"/",false]],[6,"show_new",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// towns => /towns(.:format)
  towns_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"towns",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// use_shop_coupon => /shops/:shop_id/coupons/:id/use(.:format)
  use_shop_coupon_path: function(_shop_id, _id, options) {
  return Utils.build_path(["shop_id","id"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"shops",false]],[7,"/",false]],[3,"shop_id",false]],[7,"/",false]],[6,"coupons",false]],[7,"/",false]],[3,"id",false]],[7,"/",false]],[6,"use",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// user => /users/:id(.:format)
  user_path: function(_id, options) {
  return Utils.build_path(["id"], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[3,"id",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// user_omniauth_authorize => /users/auth/:provider(.:format)
  user_omniauth_authorize_path: function(_provider, options) {
  return Utils.build_path(["provider"], ["format"], [2,[2,[2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"auth",false]],[7,"/",false]],[3,"provider",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// user_omniauth_callback => /users/auth/:action/callback(.:format)
  user_omniauth_callback_path: function(_action, options) {
  return Utils.build_path(["action"], ["format"], [2,[2,[2,[2,[2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"auth",false]],[7,"/",false]],[3,"action",false]],[7,"/",false]],[6,"callback",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// user_password => /users/password(.:format)
  user_password_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[2,[2,[7,"/",false],[6,"users",false]],[7,"/",false]],[6,"password",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// user_registration => /users(.:format)
  user_registration_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"users",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// user_session => /login(.:format)
  user_session_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"login",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  },
// users => /users(.:format)
  users_path: function(options) {
  return Utils.build_path([], ["format"], [2,[2,[7,"/",false],[6,"users",false]],[1,[2,[8,".",false],[3,"format",false]],false]], arguments);
  }}
;
  window.Routes.options = defaults;
})();
