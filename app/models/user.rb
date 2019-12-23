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
  has_many :issued_badges, dependent: :destroy
  has_many :badges, through: :issued_badges
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many  :owned_tests, class_name: "Test", inverse_of: :author, foreign_key: "author_id",
            dependent: :restrict_with_exception # rubocop:disable Layout/AlignHash

  def passed_test_passages_after_last_badge_rewarding(badge)
    selection_date = last_rewarding_badge_date(badge) || first_test_passage_date - 1.second
    passed_test_passages.after_date(selection_date)
  end

  # return date or nil when no one record found
  def last_rewarding_badge_date(badge)
    last_badge =
      issued_badges
      .where(badge: badge)
      .order(created_at: :desc)
      .first
    last_badge&.created_at
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

  private

  def first_test_passage_date
    TestPassage.order(created_at: :asc)
               .first
               .created_at
  end

end
