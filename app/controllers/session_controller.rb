class SessionController < ApplicationController

  def create
    outlet = Outlet.find_by(name: session_params["name"])

    if outlet && outlet.authenticate(session_params["password"])
      session[:outlet_id] = outlet.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
