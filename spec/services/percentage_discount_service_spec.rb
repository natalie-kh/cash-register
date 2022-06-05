# frozen_string_literal: true

require_relative "../helper"

describe PercentageDiscountService do
  describe ".call" do
    before do
      @product = Product.create("CF1", "Coffee", 11.23)
      @offer = Offer.create(:percentage, "desc", %i[min_count multiplier])
      @product_offer = ProductOffer.create("CF1", :percentage, { min_count: 3, multiplier: 2.0 / 3 })
    end

    after do
      $DB = { offers: {}, products: {}, product_offers: {} }
    end

    describe "when count of products < min_count" do
      it "returns cost without discount" do
        count = 2
        assert PercentageDiscountService.call(@product, @product_offer, count) == @product.price * count
      end
    end

    describe "when count of products == min_count" do
      it "returns cost with discount" do
        count = 3
        cost_with_discount = @product.price * count * @product_offer.rule_data[:multiplier]
        assert PercentageDiscountService.call(@product, @product_offer, count) == cost_with_discount
      end
    end

    describe "when count of products > min_count" do
      it "returns cost with discount" do
        count = 4
        cost_with_discount = @product.price * count * @product_offer.rule_data[:multiplier]
        assert PercentageDiscountService.call(@product, @product_offer, count) == cost_with_discount
      end
    end
  end
end
