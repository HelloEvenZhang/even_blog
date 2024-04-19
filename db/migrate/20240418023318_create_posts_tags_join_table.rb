class CreatePostsTagsJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :posts_tags, id: false do |t|
      t.integer :post_id
      t.integer :tag_id
    end

    add_index :posts_tags, :post_id
    add_index :posts_tags, :tag_id
  end
end
