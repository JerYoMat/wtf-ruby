require 'open-uri'
require 'pry'
require 'nokogiri'
class Scraper

      @@core_path = "./fixtures/ruby-doc-site/core-2_3_1"
      @@file_type = ".xml"

  def self.scrape_class
  class_names = []
    core_link = @@core_path + @@file_type
    core_page = Nokogiri::HTML(open(core_link))
      core_page.xpath("//div [@id='class-index']/div[2]/p/a").each do |class_name|
        class_names << class_name.text
    end
    class_names
  end

  def self.scrape_methods(class_instance_name)
     # to break up the method sections use //div [@id='at-method'] [@class='method-detail']
     methods = []
     method_link = "#{@@core_path}/#{class_instance_name}#{@@file_type}"
     method_page = Nokogiri::HTML(open(method_link))
       method_page.xpath("//div[@id='method-list-section']/ul/li/a").each do |method_name|
          name = method_name.text.gsub(/[:#]/,'')
          methods << name
       end
      methods
    end

  def self.scrape_method_content_from_class_page(class_name)
   methods = []
   method_link = @@core_path+"/Array.xml"
   method_page = Nokogiri::HTML(open(method_link))
     method_page.css(".method-detail").each do |section|
          method_hash = {}
          method_hash[:headings] =section.xpath("div [@class='method-heading'] / span").text
          method_hash[:code] = section.css(".ruby").text.split("\n")

          methods << method_hash
     end
    methods
  end

end
