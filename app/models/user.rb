# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  provider        :string
#  uid             :string
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  full_name       :string
#  email           :string
#  about           :text
#  phone           :string
#  skype           :string
#  admin           :boolean          default("f")
#  email_confirmed :boolean          default("f")
#

class User < ActiveRecord::Base

  include OmniauthRegistration

  acts_as_reader

  has_many :clubs, dependent: :destroy
  has_many :events, dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  has_many :sent_messages, class_name: 'Message', foreign_key: 'author_id', dependent: :destroy
  has_many :recieved_messages, class_name: 'Message', foreign_key: 'recipient_id', dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :full_name, :skype, allow_blank: true, length: { in: 3..15 }
  validates :email, uniqueness: true, allow_blank: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
  validates :about, allow_blank: true, length: { in: 0..100 }
  validates :phone, allow_blank: true, length: { is: 10 }

  def send_email_confirmation(email)
    self.create_confirmation(email: email)
    self.update_attributes(email_confirmed: false)
  end

end
