# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  name       :string
#  full_name  :string
#  email      :string
#  about      :text
#  phone      :string
#  skype      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

  has_many :clubs

  before_create :set_user_email_by_identity

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
      # format user name
      name = Translit.convert(auth['info']['name']).delete('\'')
      user.name = name.split(' ').join('_').downcase
    end
  end

  private

  def set_user_email_by_identity
    if self.provider == 'identity'
      email = Identity.find_by_name(self.name).email
      self.email = email
    end
  end

end
