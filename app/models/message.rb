# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  author_id         :integer
#  recipient_id      :integer
#  subject           :string
#  body              :text
#  deleted_author    :boolean          default("f")
#  deleted_recipient :boolean          default("f")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  unread            :boolean          default("t")
#

class Message < ActiveRecord::Base

  paginates_per 20

  belongs_to :author, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :body, presence: true, length: { maximum: 1000 }
  validates :subject, length: { within: 4..140 }, presence: true

  scope :active_sentbox, ->{where(deleted_author: false)}
  scope :active_inbox, ->{where(deleted_recipient: false)}

  def mark_as_read_by(user)
    update_attributes(unread: false) if (user.id == self.recipient_id)
  end

end
