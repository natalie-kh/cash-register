# frozen_string_literal: true

# Сalculates the cost of products in the cart using the offer of :bogo("buy-one-get-one-free") type.
# Also works with offers type "Buy X get Y free".
# Where X = product_offer.rule_data[:min_count] and Y = product_offer.rule_data[:free_count]

# @params product [Product] - product
# @params product_offer [ProductOffer] - active product_offer for the product
# @params count [Integer] - count of the product at the cart
# @return [Numeric] - total cost of the product at the cart

class BuyOneGetOneService < BaseService
  def call(product, product_offer, count)
    cost = product.price * count
    return cost if count <= product_offer.rule_data[:min_count]

    free_product_count = free_product_count(count, product_offer.rule_data)

    (count - free_product_count) * product.price
  end

  private

  def free_product_count(count, rule_data)
    count_for_full_offer_cycle = (rule_data[:min_count] + rule_data[:free_count])

    count_of_offers = count / count_for_full_offer_cycle
    mod = count % count_for_full_offer_cycle
    extra_free_count = mod > rule_data[:min_count] ? (mod - rule_data[:min_count]) : 0

    count_of_offers * rule_data[:free_count] + extra_free_count
  end
end
