class User < ActiveRecord::Base
  has_many :friends

  devise :database_authenticatable, :recoverable, :rememberable,
    # :confirmable,
    :omniauthable, :omniauth_providers => [:facebook]

  def self.send_reminders
    all.each{ |u| u.send_reminders_if_any }
  end

  def send_reminders_if_any
    if week_ofs.present? || day_ofs.present?
      UserMailer.birthday(self, week_ofs, day_ofs).deliver
    end
  end

  def week_ofs
    if one_week
      friends_with_birthdays_on(7.days.from_now)
    end
  end

  def day_ofs
    if day_of
      friends_with_birthdays_on(Date.today)
    end
  end

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

  private

  def friends_with_birthdays_on(target)
    friends.select do |friend|
      friend.birthday.month == target.month && friend.birthday.day == target.day
    end
  end
end
