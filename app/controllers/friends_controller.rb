class FriendsController < ApplicationController
  before_action :authenticate_user!

  def create
    params["new_friends"]["friends"].reject(&:blank?).each do |friend_id|
      fb_friend = current_user.fb_friend(friend_id)
      current_user.friends.where(:facebook_id => fb_friend.id).first_or_create do |user|
        user.name          = fb_friend.name
        user.birthday      = fb_friend.birthday.try(:change, :year => 2000)
        user.facebook_link = fb_friend.link
        user.image         = fb_friend.picture
      end
    end

    redirect_to "/user"
  end
end
