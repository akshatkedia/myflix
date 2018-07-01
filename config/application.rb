require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.assets.enabled = true
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
    config.autoload_paths << "#{Rails.root}/lib"
  end
end

Raven.configure do |config|
  config.dsn = 'https://767a413bbfe1488396434107a7b19d37:de02dc9bc4d94d1fb1a1e8957c1c5aef@sentry.io/1228119'
end
