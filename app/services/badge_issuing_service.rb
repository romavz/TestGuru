class BadgeIssuingService
  attr_reader :user
  attr_reader :test
  attr_reader :test_passage

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def call
    return [] unless test_passage.successfull?

    new_badges = Badge.all.select { |badge| send(badge.rule_name, badge.rule_value) }
    user.badges << new_badges
    new_badges
  end

  # ---------------------------
  # Issuing rules section

  # Успешно пройден первый тест
  def first_test_passed
    success_user_test_passages_count = user.test_passages.successfull.size

    success_user_test_passages_count == 1
  end

  # Тест пройден с одной попытки
  def test_passed_by_one_try
    test_passages = test.user_test_passages(user: user)
    successfull_test_passages = test_passages.successfull

    test_passages.size == 1 && successfull_test_passages.size == 1
  end

  def category_complete(category)
    category_tests_count = category.tests.size
    passed_tests_count = user.passed_tests.select_by_category(category).size

    passed_tests_count == category_tests_count
  end

  def level_complete(level_number)
    tests_by_level_count = Test.select_by_level(level_number).size
    passed_tests_count = user.passed_tests.select_by_level(level_number).size

    passed_tests_count == tests_by_level_count
  end
end
