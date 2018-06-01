class Promotion < ApplicationRecord
  belongs_to :brand
  has_many :redemptions
end
