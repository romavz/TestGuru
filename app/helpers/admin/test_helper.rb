module Admin::TestHelper
  def time_limit(test)
    I18n.t("shared.time_scale.#{test.time_scale}", count: test.time_limit)
  end
end
