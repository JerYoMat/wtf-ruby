require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"

require 'nokogiri'
require 'open-uri'
require 'pry'

class_list = Scraper.scrape_class
Class.create_from_collection(class_list)


Class.all.each do |ind_class|
  name = ind_class.name
  t = File.new("./fixtures/ruby-doc-site/core-2_3_1/#{name}.xml", 'w')
  html = open("https://ruby-doc.org/core-2.3.1/#{name}.html")
  doc = Nokogiri::HTML(html)
  t.write(doc)
  t.close
end
