require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"
require_relative "../lib/meth.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
class CommandLineInteface
#Welcom User and provide prompt

# IF No Arguments are entered, then show class list
#If Class is provided then show method list
#IF class and method are provided then go straight to method output





  def run
    make_classes
    printf_class_list
#The user selects the class for which they would like to view the methods.
    selected_class = set_class("Array")
    selected_class.create_methods_for_instance_of_class
    printf_method_list(selected_class)
    display_method(selected_class, "shuffle")
  end


  def set_method(class_instance, chosen_method_name)
    class_instance.methods.select { |m| m.name == chosen_method_name}.first
  end
#YOU ARE HERE
  def display_method(class_instance, chosen_method_name)
      m_to_show = set_method(class_instance, chosen_method_name)
      puts ''
      puts '  Class: ' + class_instance.name.colorize(:mode => :bold) + ' Method: ' + m_to_show.name.colorize(:color => :red, :mode => :bold)
      printf("\t %s \n", m_to_show.mini_description.colorize(:mode => :italic))

      m_to_show.headings.each do |heading|
       printf("\t#{heading.colorize(:light_blue)}\n")
      end
      m_to_show.sample_code.each do |code|
          line = code.colorize(:color => :white, :background => :gray)
          printf("\t %-50s \n", line)
      end

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
