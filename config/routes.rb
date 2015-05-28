Rails.application.routes.draw do
  post "/vigilion/callback", to: "vigilion/vigilion#callback"
end
