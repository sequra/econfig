require "rails"
require "econfig"

module Econfig
  class Railtie < Rails::Railtie
    initializer "econfig.setup", before: :load_environment_config do |app|
      Econfig.root = Rails.root
      Econfig.env = Rails.env
      # Use config.x namespace to avoid ActiveSupport::Configurable deprecation warning in Rails 8
      app.config.x.app = Econfig.instance
      # Maintain backward compatibility with config.app for existing code
      # This uses define_singleton_method to avoid triggering the deprecation warning
      app.config.define_singleton_method(:app) { app.config.x.app }
    end
  end
end
