class Message < ActiveRecord::Base
	belongs_to :author, class_name: "User"
	belongs_to :recipient, class_name: "User"

	validate :body, presence: true,
									length: { maximum: 1000 }
	validate :subject, 	length: { within: 4..140 },
											presence: true

	scope :active_sentbox, -> {where(deleted_author: false)}
	scope :active_inbox, -> {where(deleted_recipient: false)}

end