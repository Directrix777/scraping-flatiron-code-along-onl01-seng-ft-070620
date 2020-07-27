require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each{|course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    }
  end

  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    binding.pry
  end

  def get_courses
    get_page.css(".post")
  end

  def make_courses
    get_courses.each{|course|
    new_course = Course.new
    new_course.title = course.css("h2")
  }
  end

end

Scraper.new.get_page
