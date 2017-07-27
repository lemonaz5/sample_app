class API < Grape::API
  format :json
  prefix :api

  helpers do
    def session
      env['rack.session']
    end

    def current_user
      # Rails.logger.debug session[:user_id]
      user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end

  mount Twitter::Users
end