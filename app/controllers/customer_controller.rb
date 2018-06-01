class CustomerController < ApplicationController
  before_action :find_customer

  def point_collection
    if @customer 
      increment_points(@customer)
      redirect_to root_path
    else
      @customer = Customer.create(customer_params)
      increment_points(@customer)
      redirect_to root_path
    end
  end

  def promotion_redemption
    if @customer
      promotion = Promotion.find(promotion_params["id"])
      redeem_item(@customer, promotion)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:phone_number)
  end

  def promotion_params
    params.require(:promotion).permit(:id)
  end

  def increment_points(customer)
    incremented_points = customer.collected_points + 100
    customer.update(collected_points: incremented_points)
  end

  def redeem_item(customer, promotion)
    remaining_points = customer.collected_points - promotion.cost
    if  remaining_points > 0
      customer.update(collected_points: remaining_points) 
      "Item Redeemed Succesfully"
    else
      "Sorry not enough points"
    end
  end

  def find_customer
    @customer = Customer.find_by(phone_number: customer_params["phone_number"])
  end
end
