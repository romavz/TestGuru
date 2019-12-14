class Validators::BaseValidator

  class << self
    def validate!(subject)
      new.validate!(subject)
    end

    def valid?(subject)
      validate!(subject)
      true
    rescue StandardError
      false
    end
  end

  def validate!(subject)
    # must be implemented in child classes
    raise NotImplementedError
  end

end
