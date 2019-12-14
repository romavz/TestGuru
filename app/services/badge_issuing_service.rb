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
    return [] unless test_passage.passed?

    new_badges = Badge.all.select do |badge|
      issuing_success?(badge.rule_name, badge.rule_value)
    end
    new_badges
  end

  private

  def issuing_success?(rule_name, rule_value)
    return send(rule_name) if rule_value.blank?

    send(rule_name, rule_value)
  end

  # ---------------------------
  # Issuing rules section

  rewarding_rule :first_test_passed do
    user.passed_tests.size == 1
  end

  rewarding_rule :test_passed_by_one_try do
    test_passages = test.user_test_passages(user)
    return false if test_passages.size > 1

    successfull_test_passages = test_passages.passed

    test_passages.size == 1 && successfull_test_passages.size == 1
  end

  rewarding_rule :category_complete do |category_id|
    category_id = category_id.to_i
    category = Category.find_by(id: category_id)
    return false if category.nil?

    return false unless test.category == category

    category_tests_count = category.tests.size
    passed_tests = user.passed_tests.select_by_category(category)

    passed_tests_count = passed_tests.size
    uniq_passed_tests_count = passed_tests.distinct.size

    passed_tests_count == category_tests_count && uniq_passed_tests_count == category_tests_count
  end

  rewarding_rule :level_complete do |level_number|
    level_number = level_number.to_i
    tests_by_level_count = Test.select_by_level(level_number).size
    return false if tests_by_level_count < 1

    passed_tests = user.passed_tests.select_by_level(level_number)
    passed_tests_count = passed_tests.size
    uniq_passed_tests_count = passed_tests.distinct.size

    passed_tests_count == tests_by_level_count && uniq_passed_tests_count == tests_by_level_count
  end
end
