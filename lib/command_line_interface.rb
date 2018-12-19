require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"
require_relative "../lib/meth.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
class CommandLineInteface


  def run
    make_classes
    printf_class_list

#The user selects the class for which they would like to view the methods.
    selected_class = set_class("Array")
    selected_class.create_methods_for_instance_of_class
    printf_method_list(selected_class)

  end


  def set_method(class_instance, chosen_method_name)
    class_instance.methods.select { |m| m.name == chosen_method_name}.first
  end
#YOU ARE HERE 
  def display_method(class_instance, chosen_method_name)
      m_to_show = set_method(class_instance, chosen_method_name)
      m_to_show.name
  end


  def printf_method_list(selected_class)
    counter = 0
    rows = selected_class.methods.count/3
    rows.ceil.times do
      printf(" %2d.%-25s %2d.%-25s %2d.%-25s \n",
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
      printf(" %2d.%-15s %2d.%-15s %2d.%-15s %2d.%-15s \n",
        counter += 1, Class.all[counter - 1].name,
        counter += 1, Class.all[counter - 1].name,
        counter += 1, Class.all[counter - 1].name,
        counter += 1, Class.all[counter - 1].name)
    end
  end

end
