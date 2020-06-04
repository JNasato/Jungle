class CartsController < ApplicationController

  # Add "before_filter :authorize" to any controller to secure it from non-logged in users

  def show
  end

  def add_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, +1)

    redirect_to :back
  end

  def remove_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, -1)

    redirect_to :back
  end

  private

  def modify_cart_delta(product_id, delta)
    @product = Product.find(product_id)
    
    cart[product_id] = (cart[product_id] || 0) + delta
    cart.delete(product_id) if cart[product_id] < 1

    if @product.quantity - cart[product_id].to_i < 0
      flash[:notice] = "MAX"
      return
    else
      update_cart cart
    end
  end

end
