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

    rewarding_rule :first_test_passed do |badge|
      return false unless user.passed_tests.size == 1

      test_passage.badges << badge
      true
    end

    rewarding_rule :test_passed_by_one_try do |badge|
      test_passages = test.user_test_passages(user)
      return false if test_passages.size > 1

      successfull_test_passages = test_passages.passed

      rewarding_success?(successfull_test_passages, 1, badge)
    end

    rewarding_rule :category_complete do |badge|
      category = Category.find_by(id: badge.rule_value)
      return false unless category && category == test.category

      category_tests_count = category.tests.size
      target_passages =
        passages_without_this_badge(badge)
        .select_by_category(category)

      rewarding_success?(target_passages, category_tests_count, badge)
    end

    rewarding_rule :level_complete do |badge|
      level_number = badge.rule_value
      tests_by_level_count = Test.select_by_level(level_number).size
      return false if tests_by_level_count < 1

      target_passages =
        passages_without_this_badge(badge)
        .select_by_level(level_number)

      rewarding_success?(target_passages, tests_by_level_count, badge)
    end
  end

  def passages_without_this_badge(badge)
    user.passed_test_passages
        .without_this_badge(badge)
  end

  def rewarding_success?(target_passages, expected_count, badge)
    passed_tests_count = target_passages.select(:test_id).distinct.size
    return false unless passed_tests_count == expected_count

    target_passages.each { |tp| tp.badges << badge }
    true
  end

end
