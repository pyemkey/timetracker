class Work < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :fullday, -> { where("hours >= 8") }
  scope :recent, -> { where("date_time_performed > '#{Time.now - 7.days}'")}
end
