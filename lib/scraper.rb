require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []

  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    html.css("div.social-icon-controler a").each do |student|
      url = student.attribute("href")
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
