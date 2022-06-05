# frozen_string_literal: true

require_relative "../helper"

describe ProductOffer do
  describe ".create" do
    before do
      $DB[:products][:product_code] = {}
      $DB[:offers][:offer_code] = OpenStruct.new(required_keys: [:min_count])
    end

    it "creates new product_offer" do
      product_offer = ProductOffer.create(:product_code, :offer_code, { min_count: 1 })
      assert ProductOffer.find(:product_code) == product_offer
    end

    it "raises error when offer or product do not exist" do
      assert_raises ValidationError do
        ProductOffer.create(:code, :offer_code, { min_count: 1 })
      end

      assert ProductOffer.find(:code).nil?
    end

    it "raises error when params are invalid" do
      assert_raises ValidationError do
        ProductOffer.create(nil, nil, nil)
      end

      assert ProductOffer.find(nil).nil?
    end
  end
end
