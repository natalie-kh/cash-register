# frozen_string_literal: true

Dir["./app/**/*.rb"].sort.each { |file| require file }
Dir["./db/*.rb"].sort.each { |file| require file }

class Menu
  attr_reader :cart

  def initialize
    @cart = []
    seeds
  end

  def run
    print_menu_text
    handle_user_input
    run
  end

  private

  def seeds
    Seeds.run
  end

  def print_menu_text
    p "---------------------------------------------------"
    Product.all.each do |code, product|
      p "#{code} - add #{product.name}"
    end
    p "c - clean the basket, enter - get total, q - exit"
    p "---------------------------------------------------"
  end

  def handle_user_input
    input = gets.chomp
    case input
    when Product.find(input) && input
      @cart.push(input)
    when "c"
      @cart.clear
    when ""
      p "Total price is #{format('%.2f', TotalCostService.call(@cart))}€"
    when "q"
      exit
    end
  end
end

Menu.new.run
