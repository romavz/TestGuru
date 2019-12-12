module RewardingRule
  def self.included(target)
    target.extend(ClassMethods)
  end

  module ClassMethods
    def rewarding_rules
      @rewarding_rules ||= []
    end

    def rewarding_rule(rule_name, &block)
      rewarding_rules << rule_name.to_sym
      define_method(rule_name, &block)
    end
  end
end
