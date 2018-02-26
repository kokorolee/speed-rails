class FoxyCrmAPI < Grape::API
  format :json

  helpers do
    def declared_params
      declared(params, include_missing: false)
    end

    def current_partner
      authentication_token = $~[1] if request.headers["Authorization"] && request.headers["Authorization"] =~ /^FoxyCRM (.+)$/
      @current_partner ||= Partner.find_by(access_token: authentication_token) unless authentication_token.nil?
    end

    def authenticate!
      error!({ error: "Unauthorized" }, 401) unless current_partner
    end

  end

  mount PartnerAPI
end
