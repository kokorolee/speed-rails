class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include PublicActivity::StoreController

  rescue_from ActionController::RoutingError, with: :render_404

  private

  def render_404
    respond_to do |format|
      format.html { render "#{Rails.root}/public/404.html", status: 404 }
      format.json { render json: { status: 404, message: 'Page Not Found' } }
    end
  end

  def self.assign_params(*permitted_params)
    define_method :resource_params do
      return [] if request.get?
      if defined?(resource_request_name)
        [params.require(resource_request_name).permit(permitted_params)]
      else
        [params.require(controller_name.singularize).permit(permitted_params)]
      end
    end
  end


  def self.assign_updated_by(params_key, actions = [:update], options = {})
    self.register_saved_by(:updated_by, params_key, actions, options = {})
  end

  # Set before filter to set created_by into params of request
  def self.assign_created_by(params_key, actions = [:create], options = {})
    self.register_saved_by(:created_by, params_key, actions, options = {})
  end

  # Set before filter to set saved_by into params of request
  def self.register_saved_by(column_name, params_key, actions, options)

    if params_key
      saved_by_params = "params[:#{params_key}][:#{column_name}]"
    else
      saved_by_params = "params[:#{column_name}]"
    end

    self.class_eval %Q"
      before_filter :add_#{params_key.to_s}_#{column_name.to_s}, only: #{actions}

      private
      def add_#{params_key.to_s}_#{column_name.to_s}
        return false if params[:#{params_key}].blank?
        #{saved_by_params} = current_user.try(:id).to_s
      end
    "
  end

  def authenticate_any!
    if partner_signed_in? || user_signed_in?
        true
    else
      authenticate_user!
    end
end
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up)        { |u| u.permit( :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in)        { |u| u.permit(:login, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:phone, :email, :password, :password_confirmation, :current_password) }
    end

end
