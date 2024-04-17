class Comment < ApplicationRecord
  belongs_to :post

  validates :name, length: { maximum: 30 }
  validates :content, presence: true

  default_scope { order(:created_at) }
end
