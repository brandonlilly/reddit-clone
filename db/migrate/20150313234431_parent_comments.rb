class ParentComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_comment_id, :integer, index: true
  end
end
