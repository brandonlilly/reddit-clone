# create_table "post_subs", force: :cascade do |t|
#   t.integer  "post_id",    null: false
#   t.integer  "sub_id",     null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

class PostSub < ActiveRecord::Base
  belongs_to :post
  belongs_to :sub

  validates :post, :sub, presence: true
  validates :sub_id, uniqueness: { scope: :post_id }
end
