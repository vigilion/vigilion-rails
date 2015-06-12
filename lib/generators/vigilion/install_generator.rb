class Vigilion::InstallGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/vigilion.rb", <<INITIALIZER
Vigilion.configure do |config|
  config.access_key_id = ENV["VIGILION_ACCESS_KEY_ID"]
  config.secret_access_key = ENV["VIGILION_SECRET_ACCESS_KEY"]
end
INITIALIZER
  end
end