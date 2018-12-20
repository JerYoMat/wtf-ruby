require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"
require_relative "../lib/meth.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
class CommandLineInteface


  def run
    make_classes
    welcome_text
    first_choice = gets.strip
    if first_choice.include?(",")
      class_choice = first_choice.split(',')[0].strip
      selected_class = set_class(class_choice)
      selected_class.create_methods_for_instance_of_class
      method_choice = first_choice.split(',')[1].strip
      display_method(selected_class, method_choice)


    else 
      printf_class_list
      puts 'Please enter the name of the class for which you wish to view available methods:'
      class_choice= gets.strip
      selected_class = set_class(class_choice)
      selected_class.create_methods_for_instance_of_class
      printf_method_list(selected_class)
      puts 'Please enter the method you wish to view:'
      method_choice = gets.strip
      display_method(selected_class, method_choice)

    end
  end



  def welcome_text
    puts "Hello, welcome to what_dis_ruby?.  If you know the class and method that you wish to look up enter it in the following format:"
    puts "Class_name, method"
    puts "Othwerwise, hit enter"
  end



  def action_after_first_user_input(string)

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
          line = code.colorize(:color => :white, :background => :green)
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
