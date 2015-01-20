# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

  has_one :profile, dependent: :destroy

  after_create :build_profile, :set_profile_email_by_identity

  validates :provider, :uid, :name, presence: true
  validates_associated :profile

  def self.from_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid']) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth['info']['name']
    end
  end

  private

  def set_profile_email_by_identity
    if self.provider == 'identity'
      email = Identity.find_by_name(self.name).email
      self.profile.update_attributes(email: email)
    end
  end

  def build_profile
    self.create_profile
  end
end
