require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'Saves successfully when all fields are set' do
      cat1 = Category.new
      @product = cat1.products.new({
        name: 'Hockey Stick',
        quantity: 1000,
        price: 249.49
      })
      @product.valid?
      expect(@product.errors.full_messages).to be_empty
    end
    
    it 'Returns correct error message when name is nil' do
      cat1 = Category.new
      @product = cat1.products.new({
        name: nil,
        quantity: 1000,
        price: 249.49
      })
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'Returns correct error message when quantity is nil' do
      cat1 = Category.new
      @product = cat1.products.new({
        name: 'Hockey Stick',
        quantity: nil,
        price: 249.49
      })
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'Returns correct error message when price is nil' do
      cat1 = Category.new
      @product = cat1.products.new({
        name: 'Hockey Stick',
        quantity: 1000,
        price: nil
      })
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product.errors.full_messages.count).to eql(3)
    end

    it 'Returns correct error message when category is nil' do
      @product = Product.new({
        name: 'Hockey Stick',
        quantity: 1000,
        price: 249.49
      })
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product.errors.full_messages.count).to eql(1)
    end
  end
end
