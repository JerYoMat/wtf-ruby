
  class Wtf::Meth
    attr_accessor :name, :headings, :sample_code, :mini_description, :description, :parent

    def initialize(name, headings, description, mini_description, sample_code, parent)
       self.name = name
       self.headings = headings
       self. description = description
       self.mini_description = mini_description
       self.sample_code = sample_code
    end
  end
