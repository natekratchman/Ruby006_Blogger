# class BlogParser

#   def self.call
#     Entry.destroy_all

#     RSS_URLS.each do |author, hash|
#       Author.create(name: author) if Author.find_by(name: author).nil?
      
#       blog_url = hash["url"]
#       blog_platform = hash["platform"]

#       if blog_platform != "home"
#         json_hash = self.get_json(blog_url) 
#       end
#       if blog_platform == "home"
#         # json_hash = blog_url 
#       end
      
#       self.fetch_entry_data(author, json_hash, blog_platform)
#     end

#   end

#   def self.get_json(url)
#     uri = "https://ajax.googleapis.com/ajax/services/feed/load?v=2.0&q=#{url}" #converts xml to json when called by RestClient
#     json_output = RestClient::Request.execute :method => :get, :url => uri, :accept => :json, :ssl_version => 'TLSv1_2'
#     parsed_hash = JSON.parse(json_output)
#   end
  
#   def self.fetch_entry_data(author, json_hash, blog_platform)
#     if blog_platform == "github"  
#       json_hash["responseData"]["feed"]["entries"].each do |entry_hash|
#         entry_title = entry_hash["title"]
#         entry_url = entry_hash["link"]
#         date = entry_hash["publishedDate"]
#         entry_date = date.to_date #converts to DateTime
#         author_id = Author.find_by(name: author).id
#         Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
#       end
#     elsif blog_platform == "ghost"
#       entry_title = "visit blog home page"
#       entry_url = json_hash #just passing the blog_url through the unused json_hash here
#       entry_date = "2014-10-05".to_date
#       author_id = Author.find_by(name: author).id
#       Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
#     elsif blog_platform == "home"
#       entry_title = "visit blog home page"
#       entry_url = json_hash #just passing the blog_url through the unused json_hash here
#       entry_date = "2014-10-05".to_date
#       author_id = Author.find_by(name: author).id
#       Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
#     end
    
    
    
#     # Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
#   end 

#   BlogParser.call
# end