class AddNameToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :name, :string
  end
end
