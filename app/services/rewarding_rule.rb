module RewardingRule
  def self.included(target)
    target.extend(ClassMethods)
  end

  module ClassMethods
    def rewarding_rules
      @rewarding_rules ||= []
    end

    def rules_group(apply_when:, &block)
      raise ArgumentError, "apply_when" unless apply_when.is_a?(Symbol) || !respond_to?(apply_when)

      @condition_method = apply_when
      block.call
      @condition_method = nil
    end

    def rewarding_rule(rule_name, &block)
      rewarding_rules << rule_name.to_sym

      if condition_method.present?
        l_condition_method = condition_method
        rule_name_internal = "#{rule_name}_internal".to_sym

        define_method(rule_name_internal, &block)
        define_method(rule_name) do |rule_value|
          return false unless send(l_condition_method) # работает только с локальной переменной

          send(rule_name_internal, rule_value)
        end
        return
      end
      define_method(rule_name, &block)
    end

    private

    def condition_method
      @condition_method
    end
  end

  def applying_success?(rule_name, rule_value)
    send(rule_name, rule_value)
  end
end
