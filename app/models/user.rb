class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  has_many :works
  has_many :projects, through: :works
  has_many :projects
  
  validates :first_name, length: { minimum: 2}
  validates :last_name, length: { minimum: 5}
  validates_presence_of :company

  def to_s
    "#{first_name} #{last_name}"
  end
end
