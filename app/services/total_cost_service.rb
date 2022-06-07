# frozen_string_literal: true

# Calculates the total cost of products in the cart using all existing offers.

# @params products [Array] - an array of strings with product codes
# @return [Numeric] - the total cost of products in the cart using all existing offers

class TotalCostService < BaseService
  def call(products)
    # Note that switching to a real database will cause N+1.
    # In the case of a rails application, this can be avoided as follows:
    # products = Product.includes(:product_offers).where(code: products)
    products.tally.sum do |product_code, count|
      product_cost(product_code, count)
    end
  end

  private

  def product_cost(product_code, count)
    product = Product.find(product_code)
    offer = ProductOffer.find(product_code)
    return 0 unless product
    return product.price * count unless offer

    CalculateDiscountService.call(product, offer, count)
  end
end
