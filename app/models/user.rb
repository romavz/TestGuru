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
    Test.joins("
      INNER JOIN user_tests AS passage
        ON tests.id = passage.test_id
      INNER JOIN users
        ON users.id = passage.user_id
    ").
    where(
      tests: { level: test_level },
      users: { id: self.id }
    )
  end

end
