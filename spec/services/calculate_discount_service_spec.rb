# frozen_string_literal: true

require_relative "../helper"

describe CalculateDiscountService do
  describe ".call" do
    before do
      @product = OpenStruct.new(price: 4.11)
      @product_offer = OpenStruct.new(offer_code: :bogo)
      @mock = MiniTest::Mock.new
      @count = 2
      @mock.expect(:call, 2, [@product, @product_offer, @count])
    end

    describe "when offer_code is bogo" do
      it "calls BuyOneGetOneService" do
        BuyOneGetOneService.stub(:call, @mock) do
          CalculateDiscountService.call(@product, @product_offer, @count)
        end

        @mock.verify
      end
    end

    describe "when offer_code is bulk_purchase" do
      before { @product_offer.offer_code = :bulk_purchase }

      it "calls BulkPurchaseDiscountService" do
        BulkPurchaseDiscountService.stub(:call, @mock) do
          CalculateDiscountService.call(@product, @product_offer, @count)
        end

        @mock.verify
      end
    end

    describe "when offer_code is percentage" do
      before { @product_offer.offer_code = :percentage }

      it "calls PercentageDiscountService" do
        PercentageDiscountService.stub(:call, @mock) do
          CalculateDiscountService.call(@product, @product_offer, @count)
        end

        @mock.verify
      end
    end

    describe "when offer_code is unknown" do
      before { @product_offer.offer_code = :unknown }

      it "returns cost without discount" do
        assert CalculateDiscountService.call(@product, @product_offer, @count) == @product.price * @count
      end
    end
  end
end
