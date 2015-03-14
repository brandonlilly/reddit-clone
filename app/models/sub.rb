# create_table "subs", force: :cascade do |t|
#   t.string   "title",       null: false
#   t.string   "description"
#   t.integer  "creator_id",  null: false
#   t.datetime "created_at",  null: false
#   t.datetime "updated_at",  null: false
# end

class Sub < ActiveRecord::Base
  validates :title, :creator_id, presence: true
  validates :title, uniqueness: true
  belongs_to :creator, class_name: :User
  has_many :post_subs
  has_many :posts, through: :post_subs, source: :post
end
