Rails.application.routes.draw do
  root "home#new"

  post "/session", to: "session#create"
  post "/collect", to: "customer#point_collection", as: :point_collection
  post "/redeem", to: "customer#promotion_redemption", as: :promotion_redemption
  get "/check", to: "customer#check"
  post "/check", to: "customer#check_points", as: :check_points
end
