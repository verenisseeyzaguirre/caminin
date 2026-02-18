class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy

  def full_name
    if first_name.present? && last_name.present?
      "#{first_name.capitalize} #{last_name.capitalize}"
    else
      email
    end
  end
end
