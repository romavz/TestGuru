module RewardingRulesHelper
  def rewarding_rules
    t_path = "badges.rewarding_rules"
    BadgeIssuingService.rewarding_rules.map { |rule| [rule.to_s, t("#{t_path}.#{rule}")] }.to_h
  end
end
