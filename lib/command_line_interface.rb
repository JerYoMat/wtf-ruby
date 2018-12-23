require_relative '../config/environment.rb'


class CommandLineInteface
   attr_accessor :current_class


    def run
      #setup
      make_classes
      Scraper.store_offline

      Classy.create_methods_for_all_classes
      #collect first round of user input

      puts ''
      puts "Please see below for possible actions:".colorize(:mode => :underline)
      prompt_text
      user_string = gets.strip
      identify_and_render_class_and_method(user_string)
      user_input = ''
      puts ''
      puts ''

      puts "Enter " + bold_and_red("exit") + " to quit the application."

      until user_input == 'exit'
        prompt_text
        user_input = gets.strip
        identify_and_render_class_and_method(user_input) if user_input != 'exit'
      end

    end


    def going_again(user_input)
      more = "more".bold_and_red
      puts "For additional information enter #{more}"
      prompt_text
    end




  def identify_and_render_class_and_method(first_choice)

    if validate_choice_input(first_choice) == { "valid class" => true, "valid method" => true, "inputs" => 2}
      class_choice = first_choice.split(',')[0].strip
      @current_class = set_class(class_choice)
      method_choice = first_choice.split(',')[1].strip
    elsif validate_choice_input(first_choice) == { "valid class" => true, "valid method" => false, "inputs" => 1}
      @current_class = set_class(first_choice)
      printf_method_list(@current_class)
      puts 'Please enter the method you wish to view:'
      method_choice = gets.strip
    elsif validate_choice_input(first_choice) == { "valid class" => true, "valid method" => false, "inputs" => 2}
      @current_class = set_class(first_choice.split(',')[0].strip)
      printf_method_list(@current_class)
      puts 'Please enter the method you wish to view:'
      method_choice = gets.strip
    else
      puts "Hmmmm... I couldn't make sense of your input.  Let's try this" if first_choice != ''
      printf_class_list
      puts 'Please enter the name of the class for which you wish to view available methods:'
      class_choice= gets.strip
      @current_class = set_class(class_choice)
      printf_method_list(@current_class)
      puts 'Please enter the method you wish to view:'
      method_choice = gets.strip
    end
        display_method(@current_class, method_choice)

  end



  #return a hash that identifies whether the user provided class and method are valid.
  def validate_choice_input(string)
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


  def prompt_text
      enter = bold_and_red("ENTER")
    c_name = bold_and_red("Class_name")
    m_name = bold_and_red("method_name")
    puts "  For a list of all available classes: press #{enter}"
    puts "  For a list of methods of a particular class: #{c_name}"
    puts "  To see description and sample code for a specific class and method:"
    puts "  #{c_name}, #{m_name}"
  end





  def set_method(class_instance, chosen_method_name)
    class_instance.meth_ods.select { |m| m.name == chosen_method_name}.first
  end

  def make_classes
    Classy.create_from_collection(Scraper.scrape_class)
  end

  def set_class(string)
    Classy.all.select { |c| c.name == string}.first
  end




  def display_method(class_instance, chosen_method_name)

      m_to_show = set_method(class_instance, chosen_method_name)
      puts ''
      puts '  Class: ' + class_instance.name.colorize(:mode => :bold) + ' Method: ' + m_to_show.name.colorize(:color => :red, :mode => :bold)
      printf("\t %s \n", m_to_show.mini_description.colorize(:mode => :italic))
      m_to_show.headings.each do |heading|
       printf("\t#{heading.colorize(:light_blue)}\n")
      end
      m_to_show.sample_code.each do |code|
          line = code.colorize(:color => :white)
          printf("\t %-50s \n", line)
      end
  end


#Printing Lists to terminal and styling

  def printf_method_list(selected_class)
    counter = 0

    rows = selected_class.meth_ods.count/3
    rows.ceil.times do
      printf(" %2d.%-25s %2d.%-25s %2d.%-25s \n",
        counter += 1, selected_class.meth_ods[counter - 1].name,
        counter += 1, selected_class.meth_ods[counter - 1].name,
        counter += 1, selected_class.meth_ods[counter - 1].name)
    end
  end




  def printf_class_list
    counter = 0
    rows = Classy.all.count/4
    rows.ceil.times do
      printf(" %2d.%-22s %2d.%-22s %2d.%-22s %2d.%-22s \n",
        counter += 1, Classy.all[counter - 1].name,
        counter += 1, Classy.all[counter - 1].name,
        counter += 1, Classy.all[counter - 1].name,
        counter += 1, Classy.all[counter - 1].name)
    end
  end


    def bold_and_red(string)
      string.colorize(:mode => :bold, :color => :red)
    end


end
