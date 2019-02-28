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

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    is_a?(Admin)
  end

end
