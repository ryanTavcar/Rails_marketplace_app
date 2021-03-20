class User < ApplicationRecord
  # ASSOCIATIONS
  has_one :profile, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :order

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  before_save :remove_whitespace

  private

  def remove_whitespace
    self.email = self.email.strip
  end
         
end
