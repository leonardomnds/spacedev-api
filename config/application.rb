require_relative 'boot'

require 'rails'

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'
require 'active_storage/engine'

Bundler.require(*Rails.groups)

module SpacedevApi
  class Application < Rails::Application
    config.load_defaults 6.1
    config.autoload_paths << Rails.root.join('v1')
    config.api_only = true
    config.time_zone = ENV['TZ'] || 'Brasilia'
    config.autoloader = :classic
  end
end
