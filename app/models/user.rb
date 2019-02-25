class User < ApplicationRecord
  EMAIL_REGEXP = /@/.freeze

  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          :confirmable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many  :owned_tests, class_name: "Test", inverse_of: :author, foreign_key: "author_id",
            dependent: :restrict_with_exception # rubocop:disable Layout/AlignHash

  validates :email,
            presence: true,
            format: { with: EMAIL_REGEXP, message: "incorrect email" }

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
