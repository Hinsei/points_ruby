class SessionController < ApplicationController

  def create
    outlet = Outlet.find_by(name: session_params["name"])

    if outlet && outlet.authenticate(session_params["password"])
      session[:outlet_id] = outlet.id
      redirect_to point_and_redemption_path
    else
      redirect_to root_path
    end
  end

  def delete
    session[:outlet_id] = nil
    redirect_to point_and_redemption_path
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
