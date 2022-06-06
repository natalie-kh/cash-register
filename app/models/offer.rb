# frozen_string_literal: true

# Сlass-reference that allows to create product_offer templates.
# Creating a new offer involves adding a handler to the CalculateDiscountService

# @params code [String] - offer code (must be unique)
# @params description [String] - short description on logical idea of the offer
# @params  required_keys [Array] - array of symbols, keys required for the offer.

class Offer
  include ModelHelper

  TABLE = :offers
  INDEX_KEY = :code

  attr_reader :code, :description, :required_keys

  def initialize(code, description, required_keys)
    @code = code
    @description = description
    @required_keys = required_keys
  end

  def validate!
    errors = OfferValidator.validate!(self)
    raise ValidationError, errors unless errors.empty?
  end
end
