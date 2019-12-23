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

    rewarding_rule :first_test_passed do |_badge|
      user.passed_tests.reload.size == 1
    end

    rewarding_rule :test_passed_by_one_try do |_badge|
      test_passages = test.user_test_passages(user)
      return false if test_passages.reload.size > 1

      test_passages.passed.reload.size == 1
    end

    rewarding_rule :category_complete do |badge|
      category = Category.find_by(id: badge.rule_value)
      return false unless category && category == test.category

      expected_count = category.tests.reload.size
      target_passages =
        user
        .passed_test_passages_after_last_badge_rewarding(badge)
        .select_by_category(category)

      passed_tests_count(target_passages) == expected_count
    end

    rewarding_rule :level_complete do |badge|
      level_number = badge.rule_value
      expected_count = Test.select_by_level(level_number).reload.size
      return false if expected_count < 1

      target_passages =
        user
        .passed_test_passages_after_last_badge_rewarding(badge)
        .select_by_level(level_number)

      passed_tests_count(target_passages) == expected_count
    end
  end

  private

  def passed_tests_count(test_passages)
    test_passages.select(:test_id).distinct.size
  end

end
