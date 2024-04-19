class Comment < ApplicationRecord
  default_scope { order(:created_at) }

  belongs_to :post

  validates :name, length: { maximum: 30 }
  validates :content, presence: true
end
