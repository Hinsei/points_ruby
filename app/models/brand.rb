class Brand < ApplicationRecord
  has_many :outlets
  has_many :promotions
  has_many :collections
end
