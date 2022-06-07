# Cash-register

* Ruby version: 3.1.2
* minitest: 5.15.0

The task was to implement a cash register.
This app is able to add products to a cart and compute the total price.

**Products Registered**
| Product Code | Name | Price |  
|--|--|--|
| GR1 |  Green Tea | 3.11€ |
| SR1 |  Strawberries | 5.00 € |
| CF1 |  Coffee | 11.23 € |

**Special conditions**

- The CEO is a big fan of buy-one-get-one-free offers and green tea. 
He wants us to add a  rule to do this.

- The COO, though, likes low prices and wants people buying strawberries to get a price  discount for bulk purchases. 
If you buy 3 or more strawberries, the price should drop to 4.50€.

- The VP of Engineering is a coffee addict. 
If you buy 3 or more coffees, the price of all coffees should drop to 2/3 of the original price.

# How to run
1. Clone the repository
  ```
    git clone https://github.com/natalie-kh/cash-register.git
  ```
2. To run CLI version
  ```
    ruby menu.rb
  ```
3. To test with irb:
  * run irb
  * require the app and seeds
  ```
    Dir["./app/**/*.rb"].sort.each { |file| require file }
    require "./db/seeds"
  ```  
  * run Seeds to create products and offers from the section above
  ```
    Seeds.run
  ```     
  * Calculate the price for any products you want. Note that the price of non-existent items is zero.
    Here is an example:
  ```
    TotalCostService.call(%w[GR1 CF1 SR1 CF1 CF1]) => 30.57
  ```

# Technical notes and explanations

* I decided not to use any frameworks(like rails or sinatra) for the current task, as well as a Database, because the task required the implementation to be as simple as possible.
However, the current implementation makes it easy to switch to using a database when needed through minor tweaks to the models, 
without changing the architecture of the project. Instead of a database, all objects are stored in a hash, accessed by key, which provides O(1) select/insert speed.

* The three proposed discount schemes can be broadly described as:
  1. Buy N products and get M products for free
  2. Buy N or more products and the price of these products will drop to M
  3. Buy N or more products and the price of these products will drop to M * the price of the products


* I decided to create an Offer model, the primary duty of this model is to describe the set of necessary parameters for a discount, without indicating specific numbers, just array of keys. The values ​​for the keys are stored in the ProductOffer model object, which also contains a reference to the specific product to which the discount should be applied. 

* For example, to describe template "If you buy 3 or more strawberries, the price should drop to 4.50€"  I create an offer and after that a product_offer
```
  Offer.create(:bulk_purchase, "Get price equal to a new_price for bulk purchases from min_count", %i[min_count new_price])

  ProductOffer.create("SR1", :bulk_purchase, { min_count: 3, new_price: 4.50 })
```

* The same was done for the two remaining discounts from the Special Conditions.

```
  Offer.create(:bogo, "Buy min_count and get free_count free", %i[min_count free_count])
  
  Offer.create(:percentage, "Drop price to multiplier * price by buying min_count or more", %i[min_count multiplier])
```

As you can see, the discount parameters are very flexible, we can easily change the minimum number of products for a discount, the new price, the discount coefficien, etc. Also, any of the three discount schemes can be configured for any existing or new product with its own N and M values.
### NOTE:
The current implementation assumes that the creation of offers will not be available to the user/manager, since each new offer requires writing its own handler in the code. But managing products and discounts on them is available.
