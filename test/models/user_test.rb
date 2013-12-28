require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  	test "a user should enter a first name" do
  		user = User.new
  		assert !user.save
  		assert !user.errors[:first_name].empty?
  	end

  	test "a user should enter a last name" do
  		user = User.new
  		assert !user.save
  		assert !user.errors[:last_name].empty?
  	end


  	test "a user should enter a profile name" do
  		user = User.new
  		assert !user.save
  		assert !user.errors[:profile_name].empty?
  	end

  	test "a user should have a unique profile name" do
  		user = User.new
  		user.profile_name = 'shaunkoo'
  		user.email = "shaunktw@gmail.com"
  		user.first_name = "shaun"
  		user.last_name = "koo"
  		user.password ="password"
  		user.password_confirmation = "password"

  		users(:shaun)
  		assert !user.save
  		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new(first_name: 'Shaun', last_name: 'Koo', email: 'shaunktw2@gmail.com')
		user.password = user.password_confirmation = 'asdfasdf'
		user.profile_name ="shaun"

		assert user.valid?
	end

end
