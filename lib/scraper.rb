require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |given_student|
        name = given_student.css(".student-name").text
        location = given_student.css(".student-location").text
        profile_url = "#{given_student.attr("href")}"
        students << {name: name, location: location, profile_url: profile_url}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    doc.css("div.social-icon-controler a").each do |given_student|
      url = given_student.attribute("href")
      given_student[:twitter_url] = url if url.include?("twitter")
      given_student[:linkedin_url] = url if url.include?("linkedin")
      given_student[:github_url] = url if url.include?("github")
      given_student[:blog_url] = url if given_student.css("img").attribute("src").text.include?("rss")
  end
      student[:profile_quote] = doc.css("div.profile-quote").text
      student[:bio] = doc.css("div.bio-content p").text
  student
  end

end
