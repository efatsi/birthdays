class Friend < ActiveRecord::Base
  belongs_to :user

  validates :user, :birthday, :presence => true

  def show_birthday
    birthday.strftime("%B ") + birthday.day.ordinalize
  end
end
