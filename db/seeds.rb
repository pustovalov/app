# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "open-uri"

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words-3"

page = Nokogiri::HTML(open(url))

lines = page.css("table tr:not(:first-child)")

lines.each do |line|
  original_text = line.css("td:nth-child(2)").text
  translated_text = line.css("td:nth-child(3)").text
  Card.create(
    original_text: original_text,
    translated_text: translated_text,
    review_date: Time.zone.today + 3.days
  )
end
