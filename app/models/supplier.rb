class Supplier < ApplicationRecord
  has_many :mappings
  has_many :products, through: :mappings

  attr_accessor :active, :total
end
