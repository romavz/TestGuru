class User < ApplicationRecord

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
