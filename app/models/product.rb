class Product < ApplicationRecord
  
  # ASSOCIATIONS
  belongs_to :material
  belongs_to :user
  has_many :products_categories
  has_many :categories, through: :products_categories

  # VALIDATIONS
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: {:greater_than => 0}

end
