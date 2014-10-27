# 1. when called, Blogger scrapes all student blogs, parses for entries (author, title, url, date)
# 1.1 persist data to DB
# 2. blog entries are displayed by day (product hunt style)
## ALTERNATIVELY, you know the blog schedule! On each day, return the scheduled author's most recent post
# 3. [bonus] filter by author
# 4. [bonus] "upvoting" function -- sort by rating (day or all time)




class Kimono

  NATE = {
  "name" => "nate_blog",
  "count" => 2,
  "frequency" => "On demand",
  "version" => 2,
  "newdata" => false,
  "lastrunstatus" => "success",
  "thisversionrun" => "Mon Oct 27 2014 01:42:08 GMT+0000 (UTC)",
  "lastsuccess" => "Mon Oct 27 2014 01:42:08 GMT+0000 (UTC)",
  "results" => {
    "entries" => [
      {
        "entry_header" => {
          "text" => "Bash Hacks for the Lazy Programmer",
          "href" => "http://natekratchman.github.io/blog/bash-hacks-for-the-lazy-programmer/"
        },
        "entry_month" => "Oct",
        "entry_day" => "12",
        "entry_year" => "2014"
      },
      {
        "entry_header" => {
          "text" => "Hello World",
          "href" => "http://natekratchman.github.io/blog/hello-world/"
        },
        "entry_month" => "Oct",
        "entry_day" => "06",
        "entry_year" => "2014"
      }
    ]
  }
}

  def self.call
    # self.fetch_entry_data(get_json)
    self.fetch_entry_data(NATE)
  end

  def self.get_json
    nate = RestClient.get('https://www.kimonolabs.com/api/2pe7ma9g?apikey=RfwM0h1EGDWVDMSvsPF4ODO2jwd28yC6')
  end
  
  def self.fetch_entry_data(results_hash)
      Entry.destroy_all
      results_hash["results"]["entries"].each do |entry_hash|
      title = entry_hash["entry_header"]["text"]
      url = entry_hash["entry_header"]["href"]
      #date  
        day = entry_hash["entry_day"]
        month = entry_hash["entry_month"]
        year = entry_hash["entry_year"]
      date = "#{month} #{day}, #{year}" ## 'to_date' method, below, converts to DATETIME format

      author_name = "Nate Kratchman" #NEED TO ITERATE HERE
      author_id = Author.find_by(name: author_name).id

      Entry.create(title: title, url: url, date: date, author_id: author_id)

    end
  end


  Kimono.call
  # binding.pry

  #template
  # author = RestClient.get 'https://www.kimonolabs.com/api/{API_ID}?apikey=RfwM0h1EGDWVDMSvsPF4ODO2jwd28yC6'

end

## HASH ##

# blogs: {
#   author1: {
#     entry1: {
#       title: title,
#       date: date,
#       url: url
#     },
#     entry2: {
#       title: title,
#       date: date,
#       url: url
#     },
#     entry3: {
#       title: title,
#       date: date,
#       url: url
#     }
#   },
#   author2: {
#     entry1: {
#       title: title,
#       date: date,
#       url: url
#     },
#     entry2: {
#       title: title,
#       date: date,
#       url: url
#     },
#     entry3: {
#       title: title,
#       date: date,
#       url: url
#     }
#   },
#   author3: {
#     entry1: {
#       title: title,
#       date: date,
#       url: url
#     },
#     entry2: {
#       title: title,
#       date: date,
#       url: url
#     },
#     entry3: {
#       title: title,
#       date: date,
#       url: url
#     }
#   }
# }