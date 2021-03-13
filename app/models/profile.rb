# == Schema Information
#
# Table name: profiles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  biography  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  first_name :string
#  last_name  :string
#
class Profile < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user

  has_one_attached :picture
end
