class User < ApplicationRecord
  EMAIL_REGEXP = /@/.freeze

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many  :owned_tests, class_name: "Test", inverse_of: :author, foreign_key: "author_id",
            dependent: :restrict_with_exception # rubocop:disable Layout/AlignHash

  has_secure_password

  validates :email,
            presence: true,
            format: { with: EMAIL_REGEXP, message: "incorrect email" }

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
