class User < ActiveRecord::Base
  belongs_to :company
  has_many :works
  has_many :projects, through: :works

  validates :first_name, length: { minimum: 2}
  validates :last_name, length: { minimum: 5}
  validates_presence_of :company
end
