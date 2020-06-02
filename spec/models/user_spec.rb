require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    context "Validates fields are not nil" do
      it 'Saves successfully when all fields are set' do
        @user = User.new({
          name: 'Sylvia Palmer',
          email: 'sylpalm@gmail.com',
          password: 'password123',
          password_confirmation: 'password123'
        })
        @user.valid?
        expect(@user.errors.full_messages).to be_empty
      end
      
      it 'Returns correct error message when name is nil' do
        @user = User.new({
          name: nil,
          email: 'sylpalm@gmail.com',
          password: 'password123',
          password_confirmation: 'password123'
        })
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it 'Returns correct error message when email is nil' do
        @user = User.new({
          name: 'Sylvia Palmer',
          email: nil,
          password: 'password123',
          password_confirmation: 'password123'
        })
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'Returns correct error message when password is nil' do
        @user = User.new({
          name: 'Sylvia Palmer',
          email: 'sylpalm@gmail.com',
          password: nil,
          password_confirmation: 'password123'
        })
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'Returns correct error message when password_confirmation is nil' do
        @user = User.new({
          name: 'Sylvia Palmer',
          email: 'sylpalm@gmail.com',
          password: 'password123',
          password_confirmation: nil
        })
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end
    end

    context "Email" do
      it "Returns correct error message when email is not unique" do
        @user1 = User.create!({
          name: 'Sylvia Palmer',
          email: 'sylpalm@gmail.com',
          password: 'password123',
          password_confirmation: 'password123'
        })
        @user2 = User.new({
          name: 'Archie Cohen',
          email: 'SYLPALM@gmail.com',
          password: 'password123',
          password_confirmation: 'password123'
        })
        @user2.valid?
        expect(@user2.errors.full_messages).to include("Email has already been taken")
      end
    end

    context "Password" do
      it "Returns correct error message when passwords do not match" do
        @user = User.new({
          name: 'Sylvia Palmer',
          email: 'sylpalm@gmail.com',
          password: 'password123',
          password_confirmation: 'password456'
        })
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password") 
      end

      it "Returns correct error message when password is below minimum length" do
        @user = User.new({
          name: 'Sylvia Palmer',
          email: 'sylpalm@gmail.com',
          password: 'password',
          password_confirmation: 'password'
        })
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 10 characters)") 
        expect(@user.errors.full_messages.count).to eql(2)
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it "Returns the correct user" do
      @user = User.create!({
        name: 'Sylvia Palmer',
        email: 'sylpalm@gmail.com',
        password: 'password123',
        password_confirmation: 'password123'
      })
      expect(User.authenticate_with_credentials('sylpalm@gmail.com', 'password123')).to eql(@user)
    end

    it "Returns the correct user when given an email with whitespace" do
      @user = User.create!({
        name: 'Sylvia Palmer',
        email: 'sylpalm@gmail.com',
        password: 'password123',
        password_confirmation: 'password123'
      })
      expect(User.authenticate_with_credentials(' sylpalm@gmail.com ', 'password123')).to eql(@user)
    end

    it "Return the correct user when given an email with different case" do
      @user = User.create!({
        name: 'Sylvia Palmer',
        email: 'SylPalm@gmail.com',
        password: 'password123',
        password_confirmation: 'password123'
      })
      expect(User.authenticate_with_credentials('SYLPALM@gmail.com', 'password123')).to eql(@user)
    end
  end
end