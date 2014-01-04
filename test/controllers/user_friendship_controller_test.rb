require 'test_helper'

class UserFriendshipControllerTest < ActionController::TestCase
	context "#new" do
		context "when not logged in" do
			should "redirect to the login page" do
				get :new
				assert_response :redirect
			end
		end

	context "when logged in" do
		setup do
			sign_in users(:shaun)
		end

		should "get new page and return success" do
			assert_response :success
		end

		should "should set a flash error if the friend_id param is missing" do
			get :new, {}
			assert_equal "Friend required", flash[:error]
		end
		
		should "display the friend's name" do
			get :new, friend_id: users(:aniket)
			assert_match /#{users(:aniket).full_name}/, response.body
		end

		should "assign a new user friendship to the correct friend" do
			get :new, friend_id: users(:aniket)
			assert_equal users(:aniket), assigns(:user_friendship).friend
		end


		should "assign a new user friendship to the currently logged in user" do
			get :new, friend_id: users(:aniket)
			assert_equal users(:shaun), assigns(:user_friendship).user
		end

		should "return a 404 status if no friend is found" do
			get :new, friend_id: "invalid"
			assert_response :not_found
		end

		should "ask if user wants to request friendship" do
			get :new, friend_id: users(:aniket)
			assert_match /Do you really want to friend #{users(:aniket).full_name}?/, response.body
		end

	end
	end

	context "create" do
		context "when not logged in " do
			should "redirect to the login page" do
				get :new
				assert_response :redirect
				assert_redirected_to login_path
			end
		end

		context "when logged in" do
			setup do
				sign_in users(:shaun)
			end

			context "with no friend id" do
				setup do
					post :create
				end
				should "set the flash error message" do
					assert !flash[:error].empty?
				end
				should "redirect to the root path" do
					assert_redirected_to root_path
				end

			end

			context "with a valid friend id" do
				setup do
					post :create, user_friendship: {friend_id: users(:mike) }
				end

				should "assign a friend object" do
					assert assigns(:friend)
					assert_equal users(:mike), assigns(:friend)
				end

				should "assign a user friendship object" do
					assert assigns(:user_friendship)
					assert_equal users(:shaun), assigns(:user_friendship).user
					assert_equal users(:mike), assigns(:user_friendship).friend
				end

				should "create a friendship" do
					assert users(:shaun).friends.include?(users(:mike))
				end

				should "redirect to the profile page of the friend" do
					assert_response :redirect
					assert_redirected_to profile_path(users(:mike))
				end

				should "set the flash success message" do
					assert flash[:success]
					assert_equal "You are now friends with #{users(:mike).full_name}", flash[:success]
				end
			end



		end
	end
end
