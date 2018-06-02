Rails.application.routes.draw do
  #root
  root "home#new"

  #session
  post "/session", to: "session#create"
  delete "/session", to: "session#delete"

  #outlet
  get "/outlet", to: "outlet#new", as: :point_and_redemption
  get "/collect", to: "outlet#collect", as: :collection
  get "/redeem", to: "outlet#redeem", as: :redemption

  #customer
  get "/check", to: "customer#check"
  post "/check", to: "customer#check_points", as: :check_points
  post "/collect", to: "customer#point_collection", as: :point_collection
  post "/redeem", to: "customer#promotion_redemption", as: :promotion_redemption
end
