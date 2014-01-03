class UserFriendshipController < ApplicationController

	def user_param
		params.require(:user).permit(:friend, :friend_id)
	end

	def friend_param
		params.require(:friend).permit(:user, :user_id)
	end
end
