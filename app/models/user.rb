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

  has_many :clubs, dependent: :destroy
  has_many :events, dependent: :destroy

  has_one :confirmation

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  has_many :sent_messages, class_name: 'Message', foreign_key: 'author_id', dependent: :destroy
  has_many :recieved_messages, class_name: 'Message', foreign_key: 'recipient_id', dependent: :destroy

  validates :provider, :uid, :name, presence: true
  validates :full_name, :skype, allow_blank: true, length: { in: 3..15 }
  validates :email, uniqueness: true, allow_blank: true, format: { with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
  validates :about, allow_blank: true, length: { in: 0..100 }
  validates :phone, allow_blank: true, length: { is: 10 }

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid']) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth['info']['name']
      user.email = auth['info']['email'] if auth['info']['email'].present?
      @user = user
    end
    @user.send_email_confirmation(@user.email) if @user.email.present?
    return @user
  end

  def send_email_confirmation(email)
    self.create_confirmation(email: email)
  end

end
