# frozen_string_literal: true

class OfferValidator < BaseValidator
  REQUIRIED_PARAMS = %i[code description required_keys].freeze

  def validate!(offer)
    validate_params_presence(offer)

    errors.push({ code: "not unique" }) if Offer.find(offer.code)

    if !offer.required_keys.is_a?(Array) || offer.required_keys.empty?
      errors.push({ required_keys: "required non-empty array" })
    end

    errors
  end
end
