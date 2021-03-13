# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  like        :integer
#  description :text
#  price       :decimal(, )
#  material_id :bigint           not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Product < ApplicationRecord
  
  # ASSOCIATIONS
  belongs_to :material
  belongs_to :user
  has_many :products_categories
  has_many :categories, through: :products_categories
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :products_categories

  has_one_attached :picture

  # VALIDATIONS
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: {:greater_than => 0}

end

