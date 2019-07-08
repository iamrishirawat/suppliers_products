class Product < ApplicationRecord
  has_many :mappings
  has_many :suppliers, through: :mappings
end
