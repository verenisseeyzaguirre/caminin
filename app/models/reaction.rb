class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :kind, presence: true
end
