require_relative "../lib/scraper.rb"
require_relative "../lib/class.rb"
require 'nokogiri'
require 'colorize'
require 'pry'
class CommandLineInteface
  #BASE_PATH = "./fixtures/ruby-doc-site/"

  def run
    make_classes
    #add_attributes_to_students change to add methods to classes
    #display_students
  end

  def make_classes
    class_list = Scraper.scrape_class
    Class.create_from_collection(class_list)

  end

  def print_class_list
    counter = 0

    printf(" #{counter + 1}.%40s #{counter + 2}.%40s #{counter + 3}.%40s", Class)

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
