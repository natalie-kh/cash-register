# frozen_string_literal: true

require_relative "../helper"
require "./db/seeds"

Seeds.run

describe TotalCostService do
  describe ".call" do
    describe "when Green Tea offer is active" do
      it "returns correct total cost" do
        # 1 tea for free
        assert_operator TotalCostService.call(%w[GR1 GR1]), :==, 3.11
      end
    end

    describe "when Strawberries offer is active" do
      it "returns correct total cost" do
        # 3 * strawberry_new_price + 1 * tea_price
        assert_operator TotalCostService.call(%w[SR1 SR1 GR1 SR1]), :==, 16.61
      end
    end

    describe "when Coffee offer is active" do
      it "returns correct total cost" do
        # 1 * strawberry_price + 3 * coffee_price * (2.0 / 3.0) + 1 * tea_price
        assert_operator TotalCostService.call(%w[GR1 CF1 SR1 CF1 CF1]), :==, 30.57
      end
    end

    describe "when Coffee and Strawberies offers are active" do
      it "returns correct total cost" do
        # 3 * strawberry_new_price + 3 * coffee_price * (2.0 / 3.0)
        assert_operator TotalCostService.call(%w[SR1 CF1 SR1 CF1 CF1 SR1]), :==, 35.96
      end
    end

    describe "when product does not exist" do
      it "returns 0" do
        assert_operator TotalCostService.call(%w[GR2 GR2]), :==, 0
      end
    end

    describe "when offer for product does not exist" do
      before { @product = Product.create("NEW", "New product", 12.22) }

      it "returns price without a discount" do
        assert_operator TotalCostService.call(%w[NEW NEW]), :==, 2 * @product.price
      end
    end
  end
end
