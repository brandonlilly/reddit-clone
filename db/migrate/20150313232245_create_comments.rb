class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.integer :author_id, null: false, index: true
      t.integer :post_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
