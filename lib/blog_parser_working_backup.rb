# # 1. when called, Blogger scrapes all student blogs, parses for entries (author, title, url, date)
# # 1.1 persist data to DB
# # 2. blog entries are displayed by day (product hunt style)
# ## ALTERNATIVELY, you know the blog schedule! On each day, return the scheduled author's most recent post
# # 3. [bonus] filter by author
# # 4. [bonus] "upvoting" function -- sort by rating (day or all time)

# class BlogParser

#   def self.call
#     Entry.destroy_all
#     # Author.destroy_all

#     RSS_URLS.each do |author, hash|
#       Author.create(name: author) if Author.find_by(name: author).nil?
#       rss_url = hash["url"]
#       json_hash = self.get_json(rss_url)
#       self.fetch_entry_data(author, json_hash)
#     end

    
#   end

#   def self.get_json(url)
#     uri_json = "https://ajax.googleapis.com/ajax/services/feed/load?v=2.0&q=#{url}"
#     json_output = RestClient::Request.execute :method => :get, :url => uri_json, :accept => :json, :ssl_version => 'TLSv1_2'
#     parsed_hash = JSON.parse(json_output)
#   end
  
#   def self.fetch_entry_data(author_name, json_hash)
#     json_hash["responseData"]["feed"]["entries"].each do |entry_hash|
#       entry_title = entry_hash["title"]
#       entry_url = entry_hash["link"]
#       date = entry_hash["publishedDate"]
#       entry_date = date.to_date #converts to DateTime

#       author_id = Author.find_by(name: author_name).id
#       Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
#     end
#   end 

#   BlogParser.call
# end