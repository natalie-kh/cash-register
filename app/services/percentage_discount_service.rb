# frozen_string_literal: true

# Сalculates the cost of products in the cart using the offer of :percentage type.
# Buying N or more, the price will drop to a new_price,
# where N = product_offer.rule_data[:min_count] and
# new_price = product_offer.rule_data[:multiplier] * product.price

# @params product [Product] - product
# @params product_offer [ProductOffer] - active product_offer for the product
# @params count [Integer] - count of the product at the cart
# @return [Numeric] - total cost of the product at the cart

class PercentageDiscountService < BaseService
  def call(product, offer, count)
    total = product.price * count
    return total if count < offer.rule_data[:min_count]

    count * product.price * offer.rule_data[:multiplier]
  end
end
