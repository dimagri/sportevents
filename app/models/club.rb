# == Schema Information
#
# Table name: clubs
#
#  id           :integer          not null, primary key
#  club_type_id :integer
#  user_id      :integer
#  name         :string
#  description  :text
#  price        :integer
#  phone        :string
#  confirmed    :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Club < ActiveRecord::Base

  belongs_to :type, class_name: 'ClubType', foreign_key: 'club_type_id'
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_one :location

  validates :user_id, :club_type_id, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :phone, presence: true

  scope :confirmed, -> { where(confirmed: true) }
  scope :unconfirmed, -> { where(confirmed: false) }
  scope :search_by_type, ->(type) { where(type: type) }
end
