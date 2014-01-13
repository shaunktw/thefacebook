class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

  def friend_requested(user_frienship_id)
  	user_frienship = UserFriendship.find(user_frienship_id)
  	@user = user_frienship.user
  	@friend = user_frienship.friend
  	mail to: @friend.email,
  		 subject: "#{@user.first_name} wants to be friends on SocialNo"
  end


  def friend_requested_accepted(user_frienship_id)
  	user_frienship = UserFriendship.find(user_frienship_id)
  	@user = user_frienship.user
  	@friend = user_frienship.friend
  	mail to: @friend.email,
  		 subject: "#{@user.first_name} has accepted your friend request! Welcome to SocialNo"
  end

end
