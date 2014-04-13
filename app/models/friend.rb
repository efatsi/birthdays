class Friend < ActiveRecord::Base
  belongs_to :user

  validates :user, :birthday, :facebook_id, :presence => true
end
