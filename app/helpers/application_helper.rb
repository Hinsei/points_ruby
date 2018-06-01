module ApplicationHelper
  def current_user
    if session[:outlet_id]
      Outlet.find(session[:outlet_id])
    else
      nil
    end
  end

  def current_promotion
    if current_user
      current_user.brand.promotions
    else
      nil
    end
  end
end
