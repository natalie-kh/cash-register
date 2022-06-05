# frozen_string_literal: true

class BaseValidator
  REQUIRIED_PARAMS = [].freeze

  attr_accessor :errors

  def self.validate!(*args)
    new.validate!(*args)
  end

  def initialize
    @errors = []
  end

  private

  def validate_params_presence(object)
    self.class::REQUIRIED_PARAMS.each do |param|
      errors.push({ "#{param}": "is invalid" }) unless object.send(param)
    end
  end
end
