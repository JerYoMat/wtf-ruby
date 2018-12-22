require 'open-uri'
require 'pry'
require 'nokogiri'
require 'fileutils'





class Scraper

      @@core_path = "https://ruby-doc.org/core-2.3.1"
      @@file_type = ".html"
      @@insert = ''
  def self.scrape_class
  class_names = []

    core_link = @@core_path
    core_page = Nokogiri::HTML(open(core_link))
      core_page.xpath("//div [@id='class-index']/div[2]/p/a").each do |class_name|
        if !class_name.children.text.include?("::") && !class_name.children.text.include?("Error") && !class_name.children.text.include?("System")
          class_names << class_name.text

        end
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
   method_link = @@core_path+"/#{class_name}#{@@file_type}"
   method_page = Nokogiri::HTML(open(method_link))
     method_page.css(".method-detail").each do |section|
          method_hash = {}
          method_hash[:headings] =section.xpath("div [@class='method-heading'] / span").text
          method_hash[:mini_description] = section.xpath("div / p[1]").text.split("\n").join(' ')
          method_hash[:full_description] = section.xpath("div / p").text
          method_hash[:code] = section.css(".ruby").text.split("\n")
          methods << method_hash
     end
    methods
  end

  def self.store_offline  #Only run after making all the classes


    core_file = File.new("./fixtures/ruby-doc-site/core-2_3_1.xml", 'w')
    home = open("https://ruby-doc.org/core-2.3.1")
    doc_home = Nokogiri::HTML(home)
    core_file.write(doc_home)
    core_file.close
    Classy.all.each do |ind_class|
      name = ind_class.name
      t = File.new("./fixtures/ruby-doc-site/core-2_3_1/#{name}.xml", 'w')
      html = open("https://ruby-doc.org/core-2.3.1/#{name}.html")
      doc = Nokogiri::HTML(html)
      t.write(doc)
      t.close
    end
  end

end
