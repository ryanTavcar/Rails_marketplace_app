class Profile < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user
  accepts_nested_attributes_for :user
  
  has_one_attached :picture
  
  # VALIDATIONS
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  before_save :remove_whitespace

  private

  def remove_whitespace
    self.name = self.name.strip
    self.description = self.description.strip
    self.price = self.price.strip
  end
end
