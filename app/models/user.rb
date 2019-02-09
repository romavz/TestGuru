class User < ApplicationRecord
  has_many :user_tests, dependent: :destroy
  has_many :tests, through: :user_tests, dependent: :destroy

  has_many :owned_tests, class_name: "Test", inverse_of: :author, foreign_key: "author_id", dependent: :restrict_with_exception

  def test_passages(test_level)
    tests.merge(test_level)
  end

end
