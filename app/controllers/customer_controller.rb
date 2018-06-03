class CustomerController < ApplicationController
  before_action :find_customer, except: [:check]

  def point_collection
    if @customer 
      @collection = Collection.find_by(customer_id: @customer.id, brand_id: helpers.current_user.brand.id)
      increment_points(@collection)
    else
      @customer = Customer.create(customer_params)
      @collection = helpers.current_user.brand.collections.create(customer_id: @customer.id)
      increment_points(@collection)
    end

    respond_to do |format|
      format.js
    end
  end

  def promotion_redemption
    if @customer
      promotion = Promotion.find(promotion_params["id"])
      collection = Collection.find_by(customer_id: @customer.id, brand_id: helpers.current_user.brand.id)
      @response = redeem_item(collection, promotion).to_json
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
    brand = Brand.find(params[:brand_id])
    collection = Collection.find_by(customer_id: @customer.id, brand_id: brand.id)
    @points = {
      current: collection.collected_points,
      collected: total_points(collection.collected_points, @customer.redemptions, brand)
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

  def increment_points(collection)
    incremented_points = collection.collected_points + 100
    collection.update(collected_points: incremented_points)
    byebug
  end

  def redeem_item(collection, promotion)
    remaining_points = collection.collected_points - promotion.cost
    if  remaining_points >= 0
      collection.update(collected_points: remaining_points) 
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

  def total_points(current_points, redemptions, brand)
    outlet_ids = brand.outlets.map {|outlet| outlet.id}
    relevant_redemptions = redemptions.reject{|redemption| !outlet_ids.include?(redemption.outlet_id)}
    spent_points = relevant_redemptions.map{|redemption| redemption.promotion.cost}.reduce(:+)
    current_points + spent_points
  end

  def find_customer
    @customer = Customer.find_by(phone_number: customer_params["phone_number"])
  end
end
