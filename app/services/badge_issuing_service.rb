class BadgeIssuingService
  include RewardingRule

  attr_reader :user
  attr_reader :test
  attr_reader :test_passage

  class << self
    def accept(test_passage)
      new(test_passage).reward_new_badges
    end
  end

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def reward_new_badges
    Badge.all.select do |badge|
      applying_success?(badge.rule_name, badge)
    end
  end

  def test_passed?
    test_passage.passed?
  end

  # ---------------------------
  # Issuing rules section

  rules_group apply_when: :test_passed? do

    rewarding_rule :first_test_passed do |_value|
      user.passed_tests.size == 1
    end

    rewarding_rule :test_passed_by_one_try do |_value|
      test_passages = test.user_test_passages(user)
      return false if test_passages.size > 1

      successfull_test_passages = test_passages.passed

      test_passages.size == 1 && successfull_test_passages.size == 1
    end

    rewarding_rule :category_complete do |badge|
      return false if user.already_has_this_badge?(badge)

      category = Category.find_by(id: badge.rule_value)
      return false unless category && category == test.category

      category_tests_count = category.tests.size
      passed_tests_count = user.passed_tests.select_by_category(category).size

      passed_tests_count == category_tests_count
    end

    rewarding_rule :level_complete do |badge|
      return false if user.already_has_this_badge?(badge)

      tests_by_level_count = Test.select_by_level(level_number).size
      return false if tests_by_level_count < 1

      passed_tests_count = user.passed_tests.select_by_level(level_number).size

      passed_tests_count == tests_by_level_count
    end
  end
end
