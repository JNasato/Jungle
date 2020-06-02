require 'rails_helper'

RSpec.feature "Visitor adds product to cart", type: :feature, js: true do
  
  #SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.sentence(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "The cart total increases by 1" do

    # ACT
    visit root_path

    cart = within('nav') { find('i.fa-shopping-cart').find(:xpath, '..') }
    expect(cart).to have_text 'My Cart (0)'
    
    within('article.product', match: :first) { click_button 'Add' }

    #DEBUG
    puts page.html
    
    #VERIFY
    expect(cart).to have_text 'My Cart (1)'
  end
end
