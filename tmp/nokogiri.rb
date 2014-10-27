# 1. when called, Blogger scrapes all student blogs, parses for entries (author, title, url, date)
# 1.1 persist data to DB
# 2. blog entries are displayed by day (product hunt style)
## ALTERNATIVELY, you know the blog schedule! On each day, return the scheduled author's most recent post
# 3. [bonus] filter by author
# 4. [bonus] "upvoting" function -- sort by rating (day or all time)

require 'nokogiri'
require 'open-uri'
require 'pry'

class Blogger


  #should iterate through all students
  

  blog = open("http://natekratchman.github.io/archives/")
  author = Nokogiri::HTML(blog)

  blogs = {} 
  #top level keys will be blog authors (e.g. :nate, :kevin, :amanda)
  #second level will be entries (1, 2, 3)
  
  entries = {} 
  #top level keys will be entry attribute (:title, :date, :url)

  author_name = 
  author.css("article h1 a").each do |title|
    blogs[author]entries[:]
  end

  binding.pry
  # nate.css("").each do |entry|
  # end

end






####################################################################

# def create_project_hash
#   # html = File.read('fixtures/kickstarter.html')
#   # kickstarter = Nokogiri::HTML(html)

#   projects = {}

#   kickstarter.css("li.project.grid_4").each do |project|
#     title = project.css("h2.bbcard_name strong a").text
#     projects[title] = {
#       :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
#       :description => project.css("p.bbcard_blurb").text,
#       :location => project.css("ul.project-meta span.location-name").text,
#       :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
#     }
#   end

#   projects
# end