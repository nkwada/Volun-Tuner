# frozen_string_literal: true

require 'i18n'
I18n.locale # => :en
I18n.locale = :ja
I18n.locale # => :ja
require 'faker'
Faker::Config.locale # => :ja
Faker::Internet.email # => ".@.com"

I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
I18n.config.available_locales = :ja
I18n.default_locale = :ja