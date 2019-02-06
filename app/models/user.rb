class User < ApplicationRecord
  has_many :user_tests, dependent: :destroy
  has_many :tests, {
    through: :user_tests,
    dependent: :destroy
  }

  has_many :owned_tests, {
    class_name: "Test",
    inverse_of: :author,
    dependent: :restrict_with_exception
  }

  def test_passages(test_level)
    tests.where(level: test_level)
  end

end
