class Post < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by, 
                  against: { title: 'A', description: 'B' }, 
                  associated_against: {
                    tags: [:name]
                  },
                  using: {
                    tsearch: { dictionary: "chinese", prefix: true }
                  }

  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy
  has_one_attached :background_img

  validates_presence_of :title
  has_rich_text :content
end
