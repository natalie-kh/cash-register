# frozen_string_literal: true

# Сalculates the cost of products in the cart using the offer of :bulk_purchase type.
# Buying N or more, the price will drop to a new_price,
# where N = product_offer.rule_data[:min_count] and
# new_price = product_offer.rule_data[:new_price]

# @params product [Product] - product
# @params product_offer [ProductOffer] - active product_offer for the product
# @params count [Integer] - count of the product at the cart
# @return [Numeric] - total cost of the product at the cart

class BulkPurchaseDiscountService < BaseService
  def call(product, offer, count)
    cost = product.price * count
    return cost if count < offer.rule_data[:min_count]

    count * offer.rule_data[:new_price]
  end
end
