# frozen_string_literal: true

require 'csv'
require 'json'
data = File.open('./recipe-data.csv').read

csv = CSV.new(
  data,
  headers: true,
  header_converters: :symbol,
  converters: :all
)
recipes = csv.to_a.map(&:to_hash)

recipes.each { |recipe| Recipe.create!(recipe) }
