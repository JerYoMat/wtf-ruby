require_relative '../config/environment.rb'


class CommandLineInteface
   attr_accessor :current_class, :current_method, :user_input

    def initialize
      @user_input = ' '
    end

    def run
      #setup
      base_setup
      puts "Please see below for possible actions:".colorize(:mode => :underline)
      until @user_input.downcase == 'exit'


        prompt_text
        @user_input = gets.strip
        validate_choice_input(@user_input) unless @user_input == ''

        if @current_class == nil && @user_input != "exit"
          @user_input = ' '
          until @current_class != nil
            printf_class_list
            @user_input = gets.strip
            validate_choice_input(@user_input)
          end
        end
        if @current_class && @current_class.has_methods? && @current_method == nil
          @user_input = ''
          until @current_method != nil
            puts ''
            printf_method_list(@current_class)
            puts 'Enter the name of the method or exit to quit'
            @user_input = gets.strip
            @current_method = set_method(@current_class,@user_input) if set_method(@current_class,@user_input)
          end
        elsif @current_class && !@current_class.has_methods?
          3.times do
            printf("\n")
          end
          printf("\t%s does not have any methods.\n".colorize(:color => :cyan), @current_class.colorize(:color => :red))
          printf("\tPlease hold ctrl and click the below link for additional information.\n")
          printf("\t#{@current_class.source.colorize(:mode => :bold)}\n")
          3.times do
            printf("\n")
          end
        end
          if @current_class && @current_class.has_methods? && !@current_method.nil?
            display_method(@current_class, @current_method)
            sleep(4)
          end
        @current_class = nil
        @current_method = nil

    end
    end



  def base_setup
    make_classes
    Scraper.store_offline
    Classy.create_methods_for_all_classes
  end







#Reqs
#If given a string, this method should determine whether the string name matches an individual class,
#an individual class and method
#If valid class is received then set the class
#If valide method is received then set the method.
  def isolate_inputs(str)
    str.scan(/\w+/)
  end

  def validate_choice_input(str)
    user_inputs = isolate_inputs(str)
    if user_inputs.count <= 2 && set_class(user_inputs[0])
      @current_class = set_class(user_inputs[0])
      if user_inputs.count == 2 && set_method(@current_class, user_inputs[1])
        @current_method = set_method(@current_class, user_inputs[1])
      end

    end
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
    class_instance.meth_ods.select { |m| m.name == chosen_method_name.downcase}.first
  end

  def make_classes
    Classy.create_from_collection(Scraper.scrape_class)
  end

  def set_class(string)
    Classy.all.select { |c| c.name.upcase == string.upcase}.first
  end




  def display_method(class_instance, chosen_method)

      m_to_show = set_method(class_instance, chosen_method.name)
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
      puts ''
      puts "Source: #{class_instance.source}"
  end


#Printing Lists to terminal and styling

  def printf_method_list(selected_class)

        counter = 0
      rows = selected_class.meth_ods.count.to_f / 3.00
      remainder = selected_class.meth_ods.count % 3
      rows.floor.times do
        printf(" %2d.%-25s %2d.%-25s %2d.%-25s \n",
          counter += 1, selected_class.meth_ods[counter - 1].name,
          counter += 1, selected_class.meth_ods[counter - 1].name,
          counter += 1, selected_class.meth_ods[counter - 1].name)
      end
      remainder.times do
       printf(" %2d.%-25s", counter += 1, selected_class.meth_ods[counter - 1].name)
      end
      printf("\n")

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
    puts "Type the name of the class to see available methods."
  end


    def bold_and_red(string)
      string.colorize(:mode => :bold, :color => :green)
    end


end
