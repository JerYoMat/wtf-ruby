require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"
require_relative "../lib/method.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
class CommandLineInteface
  #BASE_PATH = "./fixtures/ruby-doc-site/"

  def run
    make_classes
    printf_class_list
    #this is where we would wait to collect user input lets assume the user selects array
     #Scraper.scrape_method_sections_from_class_page("Array")
    Scraper.scrape_methods("Array")
    
  end

  def make_classes
    class_list = Scraper.scrape_class
    Class.create_from_collection(class_list)
  end


  def make_methods

  end


  def printf_class_list
    counter = 0
    rows = Class.all.count/4
    rows.ceil.times do
      printf(" %2d.%-25s %2d.%-25s %2d.%-25s %2d.%-25s \n", counter + 1, Class.all[counter].name, counter + 2, Class.all[counter + 1].name, counter + 3, Class.all[counter + 2].name, counter + 4, Class.all[counter + 3].name)
      counter += 4
    end
  end

  def add_attributes_to_students
    Student.all.each do |student|
      attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
      student.add_student_attributes(attributes)
    end
  end

  def display_students
    Student.all.each do |student|
      puts "#{student.name.upcase}".colorize(:blue)
      puts "  location:".colorize(:light_blue) + " #{student.location}"
      puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
      puts "  bio:".colorize(:light_blue) + " #{student.bio}"
      puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
      puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
      puts "  github:".colorize(:light_blue) + " #{student.github}"
      puts "  blog:".colorize(:light_blue) + " #{student.blog}"
      puts "----------------------".colorize(:green)
    end
  end

end
