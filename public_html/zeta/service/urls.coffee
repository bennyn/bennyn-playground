Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.URLs = (->
  # Private
  host = 'https://armada-test.z-infra.com'
  urls =
    access: "#{host}/access"
    login: "#{host}/login"
    register: "#{host}/register"
    self: "#{host}/self"
    
  create_access_token_url = (url) ->
    access_token = Zeta.Storage.Session.get_access_token()
    if access_token?
      "#{url}?access_token=#{Zeta.Storage.Session.get_access_token()}"
    else
      console.log "WARNING: Your access token is expired or is not set"
      url
  
  # Public
  login: urls.login
  
  change_own_phone_number: -> 
    console.log "= Zeta.Service.URLs.change_own_phone_number"
    create_access_token_url("#{host}/self/phone")
    
  self: -> 
    console.log "= Zeta.Service.URLs.self"
    create_access_token_url("#{host}/self")    
#
)()