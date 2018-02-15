require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    # this will open up the webpage to text, and pass the url into argument
    index_page = Nokogiri::HTML(open(index_url))
    # always set the subject to an empty array
    students = []
    # select the highest css class for the information you want,
    # in this case it is the profile card that holds all the student info
    # iterate over the profile cards and name each object 'card'
    index_page.css(".roster-cards-container").each do |card|
    # now inside the object 'card' iterate over each student
      # now in 'student', pull the 4 details you need
      card.css(".student-card a").each do |student|
        #  set a name for each info you need
        # .attr is a scraping tool
        # The function returns the value of a specified element on a selected element. As with all other scraping, you will be scraping the data to a list or variable.
        # make sure to pass it with an argument that is specific to the info you want
        student_profile_link = "#{student.attr('href')}"
        student_name = student.css('.student-name').text
        student_location = student.css('.student-location').text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
      end
    end
    students
  end



  def self.scrape_profile_page(profile)
      student = {}
      profile_page = Nokogiri::HTML(open(profile))
      links = profile_page.css(".social-icon-container").children.css("a").map { |url| url.attribute('href').value}
      links.each do |link|
        if link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?("twitter")
          student[:twitter] = link
        else
          student[:blog] = link
        end
      end
      # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
      # # if profile_page.css(".social-icon-container").children.css("a")[0]
      # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[1]
      # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[2]
      # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value if profile_page.css(".social-icon-container").children.css("a")[3]
      student[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
      student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")
      student
    end

  end
