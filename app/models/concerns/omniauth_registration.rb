module OmniauthRegistration
  extend ActiveSupport::Concern

  included do
    has_one :confirmation

    validates :provider, :uid, presence: true
  end

  module ClassMethods
    def from_omniauth(auth)
      find_by_provider_and_uid(auth['provider'], auth['uid']) || create_with_omniauth(auth)
    end

    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth['info']['name']
        user.email = auth['info']['email'] if auth['info']['email'].present?
        @user = user
      end
      @user.send_email_confirmation(@user.email) if @user.email.present?
      @user
    end
  end

end