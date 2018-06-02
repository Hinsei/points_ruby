class CustomerController < ApplicationController
  before_action :find_customer, except: [:check]

  def point_collection
    if @customer 
      increment_points(@customer)
    else
      @customer = Customer.create(customer_params)
      increment_points(@customer)
    end

    respond_to do |format|
      format.js
    end
  end

  def promotion_redemption
    if @customer
      promotion = Promotion.find(promotion_params["id"])
      @response = redeem_item(@customer, promotion).to_json
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_path
    end
  end

  def check
  end

  def check_points
    @points = {
      current: @customer.collected_points,
      collected: total_points(@customer.collected_points, @customer.redemptions)
    }

    respond_to do |format|
      format.js
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
    if  remaining_points >= 0
      customer.update(collected_points: remaining_points) 
      record_redemption(@customer, promotion)
      true
    else
      false
    end
  end

  def record_redemption(customer, promotion)
    Redemption.create(
      customer_id: customer.id, 
      outlet_id: helpers.current_user.id, 
      promotion_id: promotion.id
    )
  end

  def total_points(current_points, redemptions)
    spent_points = redemptions.map{|redemption| redemption.promotion.cost}.reduce(:+)
    current_points + spent_points
  end

  def find_customer
    @customer = Customer.find_by(phone_number: customer_params["phone_number"])
  end
end
