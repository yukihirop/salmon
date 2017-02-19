require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Salmon
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config','locales','**','*.{rb,yml}').to_s]

    # cookiesを使えるようにする
    config.action_controller.perform_caching = true
    config.middleware.use ActionDispatch::Cookies

    config.generators do |g|
      g.test_framework :rspec,
          routing_specs: false,
          controller_specs: false
    end

    if ENV['RAILS_ENV'] == 'test'
      # Rebuild ./schemata/shema.json
      system('bundle exec prmd combine schemata/yml/* > schemata/schema.json')

      # shemaで定義したレスポンスと乖離があった場合テストが通らなくなる。
      schema = JSON.parse(File.read("#{Rails.root}/docs/schema/schema.json"))
      #config.middleware.use Rack::JsonSchema::ErrorHandler
      #config.middleware.use Rack::JsonSchema::ResponseValidation, schema: schema

    end

  end
end
