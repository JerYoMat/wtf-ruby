class Class

  attr_accessor :name, :link, :methods, :description, :manipulations

  @@all = []

  def initialize(name)
    @link = "https://ruby-doc.org/core-2.3.1/#{name}.html"
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end


  def self.create_from_collection(list_of_classes)
    list_of_classes.each do |class_name|
      if !class_name.include?("::") && !class_name.include?("Error") && !class_name.include?("System")
        Class.new(class_name)
      end
    end
  end

end
