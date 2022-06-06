# frozen_string_literal: true

require_relative "../helper"

describe BuyOneGetOneService do
  describe ".call" do
    before do
      @product = Product.create("GR1", "Green Tea", 3.11)
      @offer = Offer.create(:bogo, "Buy min_count and get free_count free", %i[min_count free_count])
      @product_offer = ProductOffer.create("GR1", :bogo, { min_count: 2, free_count: 1 })
    end

    after do
      $DB = { offers: {}, products: {}, product_offers: {} }
    end

    describe "when count of products < min_count" do
      it "returns cost without discount" do
        count = 1
        assert BuyOneGetOneService.call(@product, @product_offer, count) == @product.price * count
      end
    end

    describe "when count of products == min_count" do
      it "returns cost without discount" do
        count = 2
        assert BuyOneGetOneService.call(@product, @product_offer, count) == @product.price * count
      end
    end

    describe "when count of products > min_count" do
      it "returns cost with discount" do
        count = 3
        assert BuyOneGetOneService.call(@product, @product_offer, count) == 2 * @product.price
      end
    end
  end
end
