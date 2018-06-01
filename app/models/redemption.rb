class Redemption < ApplicationRecord
  belongs_to :customer
  belongs_to :promotion
  belongs_to :outlet
end
