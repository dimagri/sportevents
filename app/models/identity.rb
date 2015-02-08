# == Schema Information
#
# Table name: identities
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Identity < OmniAuth::Identity::Models::ActiveRecord

  validates :name, presence: true, length: { minimum: 3 }
  validates :email, presence: true,
                    uniqueness: true,
                    format: {
                      with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
                    }
  validates :password_digest, presence: true, length: { minimum: 6 }

end
