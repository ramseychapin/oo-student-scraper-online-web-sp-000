require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = "#{student.attr("href")}"
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
      student[:twitter_url] = url if url.include?("twitter")
      student[:linkedin_url] = url if url.include?("linkedin")
      student[:github_url] = url if url.include?("github")
      student[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
  end
      student[:profile_quote] = html.css("div.profile-quote").text
      student[:bio] = html.css("div.bio-content p").text
  student
  end

end
