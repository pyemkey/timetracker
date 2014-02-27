class Project < ActiveRecord::Base
  belongs_to :company
  has_many :works
  has_many :users, through: :works

  validates :name, presence: true, length: { minimum: 5 }
  validates_presence_of :company
  validates :default_rate, numericality: { only_integer: true, greater_than_or_equal_to: 50 }


  scope :low_default_rate, -> { where("default_rate < ?", 100)}
end
