# == Schema Information
#
# Table name: confirmations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  email      :string
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Confirmation < ActiveRecord::Base

  belongs_to :user

  before_create :generate_code
  after_create :send_email

  validates :user, presence: true

  private

  def generate_code
    self.code = SecureRandom.hex
  end

  def send_email
    UserMailer.email_confirmation(self.email, self.code).deliver_later
  end
end
