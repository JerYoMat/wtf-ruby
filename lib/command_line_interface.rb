require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"
require_relative "../lib/meth.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
class CommandLineInteface
  #BASE_PATH = "./fixtures/ruby-doc-site/"

  def run
    make_classes
    printf_class_list

#The user selects the class for which they would like to view the methods.
    selected_class = set_class("Array")
    selected_class.create_methods_for_instance_of_class
    printf_method_list(selected_class)




  end


  def printf_method_list(selected_class)
    counter = 0
    rows = selected_class.methods.count/4
    rows.ceil.times do
      printf(" %2d.%-25s %2d.%-25s %2d.%-25s %2d.%-25s \n",
        counter += 1, selected_class.methods[counter - 1].name,
        counter += 1, selected_class.methods[counter - 1].name,
        counter += 1, selected_class.methods[counter - 1].name,
        counter += 1, selected_class.methods[counter - 1].name)
    end
  end


  def set_class(user_input)
    Class.all.select { |c| c.name == user_input}.first
  end



  def make_classes
    class_list = Scraper.scrape_class
    Class.create_from_collection(class_list)
  end



  def printf_class_list
    counter = 0
    rows = Class.all.count/4
    rows.ceil.times do
      printf(" %2d.%-20s %2d.%-20s %2d.%-20s %2d.%-20s \n", counter + 1, Class.all[counter].name, counter + 2, Class.all[counter + 1].name, counter + 3, Class.all[counter + 2].name, counter + 4, Class.all[counter + 3].name)
      counter += 4
    end
  end



end
