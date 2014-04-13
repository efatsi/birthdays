class User < ActiveRecord::Base
  has_many :friends

  devise :database_authenticatable, :recoverable, :rememberable,
    # :confirmable,
    :omniauthable, :omniauth_providers => [:facebook]

  def fb_friend(id)
    fb_friends.select{|a| a.raw_attributes["id"] == id.to_s}.first.try(:fetch)
  end

  def new_fb_friends
    fb_friends.reject{|f| f.id.in? friends.pluck(:facebook_id) }
  end

  def fb_friends
    @fb_friends ||= fb_user.friends
  end

  def fb_user
    @fb_user ||= FbGraph::User.me(token).fetch
  end
end
