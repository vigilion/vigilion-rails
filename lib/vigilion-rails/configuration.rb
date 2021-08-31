module VigilionRails
  class Configuration < Rails::Railtie
    initializer "configuration.configure_default_values" do
      # Sets default configuration.
      # Please see https://github.com/vigilion/vigilion-ruby/blob/master/lib/vigilion/configuration.rb
      Vigilion.configure do |config|
        config.integration = :url
        config.loopback = Rails.env.development? || Rails.env.test?
        config.loopback_response = 'clean'
        config.active_job = false
      end
    end
  end
end
