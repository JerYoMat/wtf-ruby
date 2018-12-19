require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper


      @@core_path = "./fixtures/ruby-doc-site/core-2_3_1"


  def self.scrape_class
  class_names = []
    core_link = @@core_path + ".html"
    core_page = Nokogiri::HTML(open(core_link))
      core_page.xpath("//div [@id='class-index']/div[2]/p/a").each do |class_name|
        class_names << class_name.text
    end
    class_names
  end

  def self.scrape_methods(class_instance_name)
   method_names = []
   method_ids = []
   method_link = "#{@@core_path}/#{class_instance_name}.html"
   method_page = Nokogiri::HTML(open(method_link))
     method_page.xpath("//div[@id='method-list-section']/ul/li/a").each do |method_name|

     method_names << method_name.text
     method_ids << method_name.attr("href")

     end
     return method_names
     return method_ids
  end

end
