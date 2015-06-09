class Vigilion::InstallGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/vigilion.rb", <<INITIALIZER
Vigilion.configure do |config|
  config.api_key = ENV["VIGILION_API_KEY"]
end
INITIALIZER
  end
end