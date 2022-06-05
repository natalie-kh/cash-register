# frozen_string_literal: true

# @params code [String] - product code (must be unique)
# @params name [String] - product name
# @params price [Numeric] - product price

class Product
  include ModelHelper

  TABLE = :products
  INDEX_KEY = :code

  attr_reader :code, :name, :price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end

  def validate!
    errors = ProductValidator.validate!(self)
    raise ValidationError, errors unless errors.empty?
  end
end
