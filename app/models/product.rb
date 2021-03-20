class Product < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :material
  belongs_to :user
  has_many :products_categories, dependent: :destroy
  has_many :categories, through: :products_categories
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :products_categories
  has_one :order, dependent: :destroy

  has_one_attached :picture
  has_one_attached :file

  # VALIDATIONS
  validates :name, presence: true
  validates :description, presence: true
  validates :file, presence: true
  validates :picture, presence: true
  validates :price, presence: true, numericality: {:greater_than => 0}

  before_save :remove_whitespace

  private

  def remove_whitespace
    self.name = self.name.strip
    self.description = self.description.strip
  end

end
