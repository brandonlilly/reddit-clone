# t.string   "title",      null: false
# t.string   "url"
# t.text     "content"
# t.integer  "sub_id",     null: false
# t.integer  "author_id",  null: false
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
class Post < ActiveRecord::Base

  belongs_to :author, class_name: :User

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments

  validates :title, :author_id, presence: true
  validates :subs, presence: true

  def comments_by_parent_id
    by_parents = Hash.new { |h, k| h[k] = [] }
    comments.each do |comment|
      by_parents[comment.parent_comment_id] << comment
    end
    by_parents
  end
end
