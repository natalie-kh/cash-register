# frozen_string_literal: true

class ProductOfferValidator < BaseValidator
  REQUIRIED_PARAMS = %i[product_code offer_code rule_data].freeze

  def validate!(object)
    validate_params_presence(object)

    offer = Offer.find(object.offer_code)
    product = Product.find(object.product_code)
    errors.push(offer_code: "does not exist") unless offer
    errors.push(product_code: "does not exist") unless product

    return errors unless offer && product

    validate_rule_data(object, offer)
    errors
  end

  private

  def validate_rule_data(object, offer)
    if !object.rule_data.is_a?(Hash) || object.rule_data.keys != offer.required_keys
      errors.push({ required_keys: "required non-empty array" })
    end

    object.rule_data.each do |k, v|
      errors.push({ "#{k}": "is not a number" }) unless v.is_a?(Numeric)
    end
  end
end
