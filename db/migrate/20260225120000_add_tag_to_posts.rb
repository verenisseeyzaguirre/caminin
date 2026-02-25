class AddTagToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :tag, :string
  end
end
