class BadgeIssuingService
  include RewardingRule

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

    new_badges = Badge.all.select do |badge|
      badge_allowed?(badge) && issuing_success?(badge.rule_name, badge.rule_value)
    end
    user.badges << new_badges
    new_badges
  end

  private

  def badge_allowed?(badge)
    !(badge.for_single_time_use? && user.already_has_this_badge?(badge.id))
  end

  def issuing_success?(rule_name, rule_value)
    return send(rule_name) if rule_value.blank?

    send(rule_name, rule_value)
  end

  # ---------------------------
  # Issuing rules section

  rewarding_rule :first_test_passed do
    success_user_test_passages_count = user.test_passages.successfull.size

    success_user_test_passages_count == 1
  end

  rewarding_rule :test_passed_by_one_try do
    test_passages = test.user_test_passages(user)
    successfull_test_passages = test_passages.successfull

    test_passages.size == 1 && successfull_test_passages.size == 1
  end

  rewarding_rule :category_complete do |category_id|
    category = Category.find_by(id: category_id.to_i)
    return false if category.nil?

    category_tests_count = category.tests.size
    passed_tests_count = user.passed_tests.select_by_category(category).size

    passed_tests_count == category_tests_count
  end

  rewarding_rule :level_complete do |level_number|
    tests_by_level_count = Test.select_by_level(level_number.to_i).size
    passed_tests_count = user.passed_tests.select_by_level(level_number).size

    passed_tests_count == tests_by_level_count
  end
end
