class User < ApplicationRecord
  EMAIL_REGEXP = /@/.freeze

  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          :confirmable

  has_many :gists, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :passed_test_passages, -> { where passed: true }, class_name: "TestPassage"
  has_many :issued_badges, through: :test_passages, dependent: :destroy
  has_many :badges, -> { distinct }, through: :issued_badges
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many  :owned_tests, class_name: "Test", inverse_of: :author, foreign_key: "author_id",
            dependent: :restrict_with_exception # rubocop:disable Layout/AlignHash

  def already_has_this_badge?(badge)
    badge = user.badges.find_by(id: badge.id)
    badge.present?
  end

  def passed_tests
    tests.where(test_passages: { passed: true }).distinct
  end

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
