class MeetupUser < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :meetup_id 
end
