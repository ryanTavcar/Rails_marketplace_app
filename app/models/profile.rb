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
    self.first_name = self.first_name.strip
    self.last_name = self.last_name.strip
    self.description = self.description.strip
  end
end
