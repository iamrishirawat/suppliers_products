class Mapping < ApplicationRecord
  belongs_to :supplier
  belongs_to :product

  attr_accessor :file
end
