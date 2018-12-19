

class Class

  attr_accessor :name, :methods, :content

  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end


  def self.create_from_collection(list_of_classes)
    list_of_classes.each do |class_name|
      if !class_name.include?("::") && !class_name.include?("Error") && !class_name.include?("System")
        t = Class.new(class_name)

      end
    end
  end


  def create_methods_for_instance_of_class
     method_names = Scraper.scrape_methods(@name)
     method_contents = Scraper.scrape_method_content_from_class_page(@name)
     index_placeholder = 0
     @methods = []
    method_contents.each do |content|

       new_method_of_class = Meth.new
       new_method_of_class.name = method_names[index_placeholder]

       new_method_of_class.headings = content[:headings].split('click to    toggle source')

       new_method_of_class.sample_code = content[:code]

       @methods << new_method_of_class
       index_placeholder += 1
    end
  end

end
