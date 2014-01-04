require 'test_helper'

class UserTest < ActiveSupport::TestCase

    should have_many(:user_friendships)
    should have_many(:friends)

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

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Shaun', last_name: 'Koo', email: 'shaunktw4@gmail.com')
    user.password = user.password_confirmation ='asdfasdf'

    user.profile_name = 'shaunktw2'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:shaun).friends
    end
end

  test "that creating friendships on a user works" do
    users(:shaun).friends << users(:mike)
    users(:shaun).friends.reload
    assert users(:shaun).friends.include?(users(:mike))
  end

  test "that calling to_param on a user returns the profile_name" do
    assert_equal "shaunkoo", users(:shaun).to_param
  end


end
