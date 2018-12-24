

  class Wtf::Scraper
    @@local_status = false
    @@dir_two = File.dirname("./fixtures/ruby-doc-site")

  #Sets the path for scraping based on the presence of the fixtures directory
    if File.directory?(@@dir_two)
      @@core_path = "./fixtures/ruby-doc-site"
      @@file_type = ".xml"
      @@local_status = true
    else
        @@core_path = "https://ruby-doc.org/core-2.3.1"
        @@file_type = ".html"
        @@local_status = false

    end


    def self.local_status
      @@local_status
    end






    def self.scrape_class
    class_names = []
      if @@local_status == true
        core_link = "#{@@core_path}/core-2_3_1.xml"
      else
        core_link = @@core_path
      end

      core_page = Nokogiri::HTML(open(core_link))
        core_page.xpath("//div [@id='class-index']/div[2]/p/a").each do |class_name|
          if !class_name.children.text.include?("::")
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
     meth_ods = []
     method_link = @@core_path+"/#{class_name}#{@@file_type}"
     method_page = Nokogiri::HTML(open(method_link))
       method_page.css(".method-detail").each do |section|
            method_hash = {}
            method_hash[:headings] =section.xpath("div [@class='method-heading'] / span").text
            method_hash[:mini_description] = section.xpath("div / p[1]").text.split("\n").join(' ')
            method_hash[:full_description] = section.xpath("div / p").text
            method_hash[:code] = section.css(".ruby").text.split("\n")
            meth_ods << method_hash
       end
      meth_ods
    end

    def self.store_offline  #Only run after making all the classes
     if @@local_status == false
        dir_one = File.dirname("./fixtures")
        unless File.directory?(dir_one)
          FileUtils.mkdir_p(dir_one)
        end

        dir_two = File.dirname("./fixtures/ruby-doc-site")
        unless File.directory?(dir_two)
          FileUtils.mkdir_p(dir_two)
        end

        dir_three = File.dirname("./fixtures/ruby-doc-site/why")
        unless File.directory?(dir_three)
          FileUtils.mkdir_p(dir_three)
        end

        core_file = File.new("./fixtures/ruby-doc-site/core-2_3_1.xml", 'w')
        home = open("https://ruby-doc.org/core-2.3.1")
        doc_home = Nokogiri::HTML(home)
        core_file.write(doc_home)
        core_file.close


        Wtf::Classy.all.each do |ind_class|
          name = ind_class.name
          t = File.new("./fixtures/ruby-doc-site/#{name}.xml", 'w')
          html = open("https://ruby-doc.org/core-2.3.1/#{name}.html")
          doc = Nokogiri::HTML(html)
          t.write(doc)
          t.close
        end
      end
    end

  end
