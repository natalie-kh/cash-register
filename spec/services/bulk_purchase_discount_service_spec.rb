# frozen_string_literal: true

require_relative "../helper"

describe BulkPurchaseDiscountService do
  describe ".call" do
    before do
      @product = Product.create("SR1", "Strawberries", 5.00)
      @offer = Offer.create(:bulk_purchase, "desc", %i[min_count new_price])
      @product_offer = ProductOffer.create("SR1", :bulk_purchase, { min_count: 3, new_price: 4.50 })
    end

    after do
      $DB = { offers: {}, products: {}, product_offers: {} }
    end

    describe "when count of products < min_count" do
      it "returns cost without discount" do
        count = 2
        assert BulkPurchaseDiscountService.call(@product, @product_offer, count) == @product.price * count
      end
    end

    describe "when count of products == min_count" do
      it "returns cost with discount" do
        count = 3
        assert BulkPurchaseDiscountService.call(@product, @product_offer, count) == @product_offer.rule_data[:new_price] * count
      end
    end

    describe "when count of products > min_count" do
      it "returns cost with discount" do
        count = 4
        assert BulkPurchaseDiscountService.call(@product, @product_offer, count) == @product_offer.rule_data[:new_price] * count
      end
    end
  end
end
