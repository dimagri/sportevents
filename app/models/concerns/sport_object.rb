module SportObject
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: 'User', foreign_key: 'user_id'
    has_one :location, as: :locationable, dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    validates :author, :location, presence: true
    validates :name, presence: true, length: { minimum: 5 }
    validates :description, presence: true, length: { minimum: 20 }
    validates :phone, presence: true
  end

end