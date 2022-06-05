# frozen_string_literal: true

# Allows creating a discount for a product based on the requiried_keys of an offer.

# @params product_code [String] - product code
# @params offer_code [String] - offer code
# @params rule_data [Hash] - key-value pairs, where keys are equal offer.required_keys

class ProductOffer
  include ModelHelper

  TABLE = :product_offers
  INDEX_KEY = :product_code

  attr_reader :product_code, :offer_code, :rule_data

  def initialize(product_code, offer_code, rule_data)
    @product_code = product_code
    @offer_code = offer_code
    @rule_data = rule_data
  end

  def validate!
    errors = ProductOfferValidator.validate!(self)
    raise ValidationError, errors unless errors.empty?
  end
end
