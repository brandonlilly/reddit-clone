class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false, index: true
      t.string :description
      t.integer :creator_id, null: false, index: true

      t.timestamps null: false
    end

    add_index :subs, :title, unique: true
  end
end
