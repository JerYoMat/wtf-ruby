require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"
require_relative "../lib/meth.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
require 'open-uri'
class CommandLineInteface



    def run
      make_classes
      Classy.create_methods_for_all_classes
      Scraper.store_offline
      welcome_text
      first_choice = gets.strip
      if validate_first_choice_input(first_choice) == { "valid class" => true, "valid method" => true, "inputs" => 2}
        class_choice = first_choice.split(',')[0].strip
        selected_class = set_class(class_choice)
        method_choice = first_choice.split(',')[1].strip
        display_method(selected_class, method_choice)
      elsif validate_first_choice_input(first_choice) == { "valid class" => true, "valid method" => false, "inputs" => 1}
        selected_class = set_class(first_choice)
        printf_method_list(selected_class)
        puts 'Please enter the method you wish to view:'
        method_choice = gets.strip
        display_method(selected_class, method_choice)
      elsif validate_first_choice_input(first_choice) == { "valid class" => true, "valid method" => false, "inputs" => 2}
        selected_class = set_class(first_choice.split(',')[0].strip)
        printf_method_list(selected_class)
        puts 'Please enter the method you wish to view:'
        method_choice = gets.strip
        display_method(selected_class, method_choice)
      else
        puts "Hmmmm... I couldn't make sense of your input.  Let's try this" if first_choice != ''
        printf_class_list
        puts 'Please enter the name of the class for which you wish to view available methods:'
        class_choice= gets.strip
        selected_class = set_class(class_choice)
        printf_method_list(selected_class)
        puts 'Please enter the method you wish to view:'
        method_choice = gets.strip
        display_method(selected_class, method_choice)

      end
  end

  #return a hash that identifies whether the user provided class and method are valid.
  def validate_first_choice_input(string)
    inputs = { "valid class" => false, "valid method" => false, "inputs" => 0 }
    if set_class(string)
      inputs["valid class"] = true
      inputs["inputs"] = 1
    elsif string.include?(',')
      array = string.split(',')
      pot_class = array[0].strip
      pot_method = array[1].strip
      inputs["inputs"] = array.count
      if set_class(pot_class)
        inputs["valid class"] = true
        if set_method(set_class(pot_class), pot_method)
          inputs["valid method"] = true
        end
      end
    end
    inputs
  end




  def welcome_text
    puts "Hello, welcome to what_dis_ruby?.  If you know the class AND method  OR just the class that you wish to look up please enter them as shown below:"
    puts "Classy and Method: Classy, Method"
    puts "Just Classy: Classy"
    puts "Othwerwise, hit enter to see a list of available classes"
  end



  def set_method(class_instance, chosen_method_name)
    class_instance.methods.select { |m| m.name == chosen_method_name}.first
  end

  def set_class(string)
    Classy.all.select { |c| c.name == string}.first
  end

  def display_method(class_instance, chosen_method_name)
      m_to_show = set_method(class_instance, chosen_method_name)
      puts ''
      puts '  Classy: ' + class_instance.name.colorize(:mode => :bold) + ' Method: ' + m_to_show.name.colorize(:color => :red, :mode => :bold)
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



  def make_classes
    class_list = Scraper.scrape_class
    Classy.create_from_collection(class_list)

  end


  def printf_class_list
    counter = 0
    rows = Classy.all.count/4
    rows.ceil.times do
      printf(" %2d.%-15s %2d.%-15s %2d.%-15s %2d.%-15s \n",
        counter += 1, Classy.all[counter - 1].name,
        counter += 1, Classy.all[counter - 1].name,
        counter += 1, Classy.all[counter - 1].name,
        counter += 1, Classy.all[counter - 1].name)
    end
  end

end
