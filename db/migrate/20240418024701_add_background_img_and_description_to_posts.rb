class AddBackgroundImgAndDescriptionToPosts < ActiveRecord::Migration[7.1]
  def change
    change_table :posts do |t|
      t.text :description
    end
  end
end
