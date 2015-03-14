  #
  # create_table "users", force: :cascade do |t|
  #   t.string   "username",        null: false
  #   t.string   "password_digest", null: false
  #   t.string   "session_token",   null: false
  #   t.datetime "created_at",      null: false
  #   t.datetime "updated_at",      null: false
  # end
  #
  # add_index "users", ["password_digest"], name: "index_users_on_password_digest", unique: true, using: :btree
  # add_index "users", ["session_token"

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :subs, foreign_key: :creator_id
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_token
  end
end
