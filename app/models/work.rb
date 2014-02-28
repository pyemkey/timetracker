class Work < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :hours, numericality: { only_integer: true, greater_than: 0 }
  validates_presence_of :project, :user, :date_time_performed
  validate :date_time_cannot_be_in_the_future
  validates :hours, length: { in: 1..8 }
  scope :fullday, -> { where("hours >= 8") }
  #scope :recent, -> { where("date_time_performed > '#{Time.now - 7.days}'")}

  def self.recent_works number_of_days_ago
    since_date = Time.now - number_of_days_ago.to_i.days
    where("date_time_performed > '#{since_date}'")
  end
  private
    def date_time_cannot_be_in_the_future
      if date_time_performed.present? && date_time_performed > Time.now
        errors.add(:date_time_performed, "can't be in future")
      end
    end
end
