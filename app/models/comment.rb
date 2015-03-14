class Comment < ActiveRecord::Base
  validates :content, :author_id, :post_id, presence: true
  belongs_to :author, class_name: :User

  belongs_to :post

  belongs_to :parent, foreign_key: :parent_comment_id, class_name: :Comment
  has_many :child_comments, foreign_key: :parent_comment_id, class_name: :Comment

end
