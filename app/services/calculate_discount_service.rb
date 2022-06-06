# frozen_string_literal: true

# Сalls the service responsible for calculating the cost of a product based on a product_offer code
# or calculates price without discount if the product_offer code is unknown

# @params product [Product] - product
# @params product_offer [ProductOffer] - active product_offer for the product
# @params count [Integer] - count of the product at the cart
# @return [Numeric] - total cost of the product at the cart

class CalculateDiscountService < BaseService
  def call(product, product_offer, count)
    case product_offer.offer_code
    when :bogo
      BuyOneGetOneService.call(product, product_offer, count)
    when :bulk_purchase
      BulkPurchaseDiscountService.call(product, product_offer, count)
    when :percentage
      PercentageDiscountService.call(product, product_offer, count)
    else
      product.price * count
    end.round(2)
  end
end
