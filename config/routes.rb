Rails.application.routes.draw do
  post "/vigilion/callback", to: "scans#callback"
end
