# frozen_string_literal: true

require_relative "../helper"

describe Product do
  describe ".create" do
    it "raises error when params are invalid" do
      assert_raises ValidationError do
        Product.create(nil, nil, nil)
      end
      assert Product.all.empty?
    end

    it "creates new product" do
      product = Product.create(:code, "name", 3.00)
      assert Product.find(:code) == product
    end
  end
end
