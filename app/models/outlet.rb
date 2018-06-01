class Outlet < ApplicationRecord
  has_secure_password
  belongs_to :brand
end
