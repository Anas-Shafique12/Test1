class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :user_projects
  has_many :projects, through: :user_projects
  validates_presence_of :name
  validates :email, format: { with: /\A[\w+\-.]+@gmail\.com\z/, message: "must be a valid Gmail address (e.g. xyz@gmail.com)" }

  def first_name
    self.name.split[0]
  end
  def last_name
    self.name.split[1]
  end
end
