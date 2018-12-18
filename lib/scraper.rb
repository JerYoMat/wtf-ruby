require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

  def self.scrape_class
  class_names = []
  core_url = "./fixtures/ruby-doc-site/core-2_3_1.html"
    core_page = Nokogiri::HTML(open(core_url))
      core_page.xpath("//div [@id='class-index']/div[2]/p/a").each do |class_name|
        class_names << class_name.text
    end
    class_names
  end

end

Scraper.scrape_class
