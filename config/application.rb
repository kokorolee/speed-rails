require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FoxyCrm
  class Application < Rails::Application

    #config.active_record.raise_in_transactional_callbacks = true
    # config.active_job.queue_adapter = :sucker_punch
    config.autoload_paths << Rails.root.join('app/api/v1')
    config.time_zone = 'Asia/Bangkok'
    config.active_record.default_timezone = 'Asia/Bangkok'
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.active_record.default_timezone = :local
    config.to_prepare do
      Devise::SessionsController.layout "auth"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "auth" }
      Devise::ConfirmationsController.layout "auth"
      # Devise::UnlocksController.layout "your_layout_name"
      Devise::PasswordsController.layout "auth"
    end


  end
end
