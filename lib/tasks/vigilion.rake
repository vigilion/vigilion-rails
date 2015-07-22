namespace :vigilion do
  desc "Ensure vigilion credentials are valid and can connect to the server"
  task test: :environment do
    project = Vigilion::HTTP.new.validate

    puts "Credentials OK!"
    puts "  Project: #{project['name']}"
    puts "  Callback: #{project['callback_url']}"

  end

end
