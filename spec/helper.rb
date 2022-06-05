# frozen_string_literal: true

require "minitest/autorun"
require "minitest/spec"
require "ostruct"
require "pry"
Dir["app/**/*.rb"].sort.each { |file| require_relative "../#{file}" }

$DB = { offers: {}, products: {}, product_offers: {} }
