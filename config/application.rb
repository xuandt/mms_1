require File.expand_path('../boot', __FILE__)
require 'csv'
require 'rails/all'

Bundler.require(:default, Rails.env)

module Mms1
  class Application < Rails::Application
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    I18n.enforce_available_locales = true
  end
end