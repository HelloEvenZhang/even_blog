class Comment < ApplicationRecord
  belongs_to :post
  broadcasts_to :post

  validates :name, length: { maximum: 30 }
  validates :content, presence: true
end
