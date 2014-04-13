class User < ActiveRecord::Base
  has_many :friends

  devise :database_authenticatable, :recoverable, :rememberable,
    # :confirmable,
    :omniauthable, :omniauth_providers => [:facebook]

  def fb_friend(id)
    fb_friends.select{|a| a.raw_attributes["id"] == id.to_s}.first.try(:fetch)
  end

  def fb_friends
    @fb_friends ||= fb_user.friends
  end

  def fb_user
    @fb_user ||= FbGraph::User.me(token).fetch
  end
end


# {"provider"=>"facebook",
#  "uid"=>"668242748",
#  "info"=>
#  {"nickname"=>"eli.fatsi",
#    "email"=>"letitsnow1415@hotmail.com",
#    "name"=>"Eli Fatsi",
#    "first_name"=>"Eli",
#    "last_name"=>"Fatsi",
#    "image"=>"http://graph.facebook.com/668242748/picture",
#    "urls"=>{"Facebook"=>"https://www.facebook.com/eli.fatsi"},
#    "location"=>"Boulder, Colorado",
#    "verified"=>true},
#    "credentials"=>
#    {"token"=>
#     "CAAJ2mtUAgcYBAAWlfd6WCerW3H0RPOuhvNZAM5HEXMsFySHx6ZB0KXP17ypYNQU5DJ3sxOES7EvaxcSbEeT6AvfXKau0hf19i1DYCSwxgb6rNoEc3Y1e8OBtqYPf5qMpFp3hcxBaXCTJxFUIbQZAPYFnYU3gLTeKHVrxBYqGI75nojz5GkI7HpWuIZANX1gZD",
#     "expires_at"=>1402605841,
#     "expires"=>true},
#     "extra"=>
#     {"raw_info"=>
#       {"id"=>"668242748",
#        "email"=>"letitsnow1415@hotmail.com",
#        "first_name"=>"Eli",
#        "gender"=>"male",
#        "hometown"=>{"id"=>"106041102761306", "name"=>"Midlothian, Virginia"},
#        "last_name"=>"Fatsi",
#        "link"=>"https://www.facebook.com/eli.fatsi",
#        "location"=>{"id"=>"106083096088679", "name"=>"Boulder, Colorado"},
#        "locale"=>"en_US",
#        "name"=>"Eli Fatsi",
#        "timezone"=>-6,
#        "updated_time"=>"2014-03-08T14:26:57+0000",
#        "username"=>"eli.fatsi",
#        "verified"=>true,
#        "work"=>
#        [{"employer"=>
#          {"id"=>"109269698697", "name"=>"Camp Alleghany for Girls"}}]}}}
