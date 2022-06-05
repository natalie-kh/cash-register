# frozen_string_literal: true

require_relative "../helper"

describe Offer do
  describe ".create" do
    it "raises error when params are invalid" do
      assert_raises ValidationError do
        Offer.create(nil, nil, nil)
      end

      assert Offer.all.empty?
    end

    it "creates new offer" do
      offer = Offer.create(:code, "description", %i[key1 key2])
      assert Offer.find(:code) == offer
    end
  end
end
