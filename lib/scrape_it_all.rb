require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"

require 'nokogiri'
require 'open-uri'


t = File.new('./fixtures/ruby-doc-site/core-2_3_1/test_file.rb', 'w')
