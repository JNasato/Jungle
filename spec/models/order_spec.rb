require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      cat1 = Category.create!(name: 'Sports')
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!({
        category: cat1,
        name: 'Hockey Stick',
        quantity: 12,
        price: 249.49
      })
      @product2 = Product.create!({
        category: cat1,
        name: 'Goalie Mask',
        quantity: 3,
        price: 729.99
      })
      # Setup at least one product that will NOT be in the order
      @product3 = Product.create!({
        category: cat1,
        name: 'Unsharpened Skate',
        quantity: 100,
        price: 14.99
      })
    end

    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      expect(@product1.quantity).to eql(12)
      expect(@product2.quantity).to eql(3)
      expect(@product3.quantity).to eql(100)
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new({
        email: 'peteyd@gmail.com',
        total_cents: 172795,
        stripe_charge_id: 1
      })
      # 2. build line items on @order
      @order.line_items.new({
        product: @product1,
        quantity: 4,
        item_price: 249.49,
        total_price: 997.96
      })
      @order.line_items.new({
        product: @product2,
        quantity: 1,
        item_price: 729.99,
        total_price: 729.99
      })
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eql(8)
      expect(@product2.quantity).to eql(2)
      expect(@product3.quantity).to eql(100)
    end
  end
end

