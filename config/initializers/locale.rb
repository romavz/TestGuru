module TestGuru
  class Application < Rails::Application
    I18n.available_locales = %i[en ru]
    I18n.default_locale = :ru
  end
end
