
  class Wtf::Classy

  attr_accessor :name, :meth_ods, :source

  @@all = []


  def initialize(name)
    @name = name
    @meth_ods = []
    @source = "https://ruby-doc.org/core-2.3.1/" + name + ".html"
    @@all << self
  end

  def self.all
    @@all
  end


  def self.create_from_collection(list_of_classes)
    list_of_classes.each do |class_name|
        Wtf::Classy.new(class_name)
    end
  end

  def self.create_methods_for_all_classes

    self.all.each do |ind_class|

        ind_class.create_methods_for_instance_of_class
    end
  end

  def has_methods?
    self.meth_ods == [] ? false : true
  end


  def create_methods_for_instance_of_class

     method_names = Wtf::Scraper.scrape_methods(@name)
     method_contents = Wtf::Scraper.scrape_method_content_from_class_page(@name)
     index_placeholder = 0
     method_contents.each do |content|

      new_method = Wtf::Meth.new(method_names[index_placeholder], content[:headings].split('click to toggle source'), content[:full_description], content[:mini_description], content[:code], self)
       self.meth_ods << new_method
       index_placeholder += 1
    end

  end
  end
