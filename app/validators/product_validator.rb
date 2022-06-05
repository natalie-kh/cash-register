# frozen_string_literal: true

class ProductValidator < BaseValidator
  REQUIRIED_PARAMS = %i[code name price].freeze

  def validate!(product)
    validate_params_presence(product)

    errors.push({ code: "not unique" }) if Product.find(product.code)
    errors.push({ price: "is not a number" }) unless product.price.is_a?(Float)

    errors
  end
end
