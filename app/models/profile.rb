# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  full_name  :string
#  email      :string
#  about      :text
#  phone      :string
#  skype      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ActiveRecord::Base

  # TODO add views

  belongs_to :user

  validates :full_name, :skype, allow_blank: true, length: { in: 3..15 }
  validates :email, uniqueness: true, allow_blank: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
  validates :about, allow_blank: true, length: { in: 0..100 }
  validates :phone, allow_blank: true, length: { is: 10 }

end
