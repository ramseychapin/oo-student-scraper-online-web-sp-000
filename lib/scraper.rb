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
  #   student[:profile_quote] = doc.css("div.profile-quote").text
  #   student[:bio] = doc.css("div.bio-content p").text
  #   doc.css("div.social-icon-controler a").each do |given_student|
  #     url = given_student.attribute("href")
  #     given_student[:github_url] = url if url.include?("github")
  #     given_student[:linkedin_url] = url if url.include?("linkedin")
  #     given_student[:blog_url] = url if given_student.css("img").attribute("src").text.include?("rss")
  #     given_student[:twitter_url] = url if url.include?("twitter")
  # end
  container = page.css(".social-icon-container a").collect{|icon| icon.attribute("href").value}
      container.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        elsif link.include?(".com")
          student[:blog] = link
        end
      end
      student[:profile_quote] = page.css(".profile-quote").text
      student[:bio] = page.css("div.description-holder p").text
  end
  student
  end

end
