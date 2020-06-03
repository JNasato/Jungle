require 'rails_helper'

RSpec.feature "A user attempts to log in", type: :feature, js: true do
  
  #SETUP
  before :each do
    @user = User.create!({
      name: 'Nick Kroll',
      email: 'peteyd@gmail.com',
      password: 'password123',
      password_confirmation: 'password123'
    })
  end

  scenario "They successfully login and are redirected to home page" do

    #ACT
    visit '/login'

    expect(page).not_to have_text 'Signed in as Nick Kroll'

    within('form') do 
      fill_in 'email', with: 'peteyd@gmail.com' 
      fill_in 'password', with: 'password123'
      find('input[value="Submit"]').click
    end

    #VERIFY
    expect(page).to have_text 'Signed in as Nick Kroll'
  end
end
