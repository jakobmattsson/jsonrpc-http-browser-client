argsToQueryString = (args) ->
  Object.keys(args).map (key) ->
    encodeURIComponent(key) + '=' + encodeURIComponent(args[key])
  .join('&')

exports.construct = ({ endpoint, jQuery }) ->
  (method, params, callback) ->
    jQuery.ajax
      dataType: 'jsonp'
      cache: true
      url: endpoint + '/' + method + '?' + argsToQueryString(params)
      jsonp: 'callback'
      error: (data) -> callback(data)
      success: (data) ->
        if data.error?
          callback(data.error)
        else
          callback(null, data.result)
