class User < ApplicationRecord
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages, dependent: :destroy
  has_many :owned_tests, class_name: "Test", inverse_of: :author, foreign_key: "author_id", dependent: :restrict_with_exception

  validates :email, presence: true

  # def test_passages(test_level)
  #   tests.where(level: test_level)
  # end
  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

end
