# frozen_string_literal: true

class Seeds
  def self.run
    $DB = { offers: {}, products: {}, product_offers: {} }

    Product.create("GR1", "Green Tea", 3.11)
    Product.create("SR1", "Strawberries", 5.00)
    Product.create("CF1", "Coffee", 11.23)

    Offer.create(:bogo, "Buy min_count and get free_count free", %i[min_count free_count])
    Offer.create(:bulk_purchase, "Get price equal to new_price for bulk purchases from min_count",
                 %i[min_count new_price])
    Offer.create(:percentage, "Drop price to multiplier * price by buying min_count or more",
                 %i[min_count multiplier])

    ProductOffer.create("GR1", :bogo, { min_count: 1, free_count: 1 })
    ProductOffer.create("SR1", :bulk_purchase, { min_count: 3, new_price: 4.50 })
    ProductOffer.create("CF1", :percentage, { min_count: 3, multiplier: 2.0 / 3 })
  end
end
