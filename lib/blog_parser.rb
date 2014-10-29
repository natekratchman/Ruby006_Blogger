class BlogParser

  def self.call
    # Entry.destroy_all

    RSS_URLS.each do |author, hash|
      Author.create(name: author) if Author.find_by(name: author).nil?
      
      blog_url = hash["url"]
      blog_platform = hash["platform"]

      if blog_platform == "home"
        self.create_home_entries(author, blog_url)
      else
        noko_hash = self.get_hash(blog_url) 
        self.create_entries(author, noko_hash, blog_platform)
      end
    end
  end

  def self.get_hash(url)
    # noko_hash = Hash.from_xml(Nokogiri::XML(open(url)).to_s)
    hash = RSS::Parser.parse(url)
    binding.pry####!!!!!!!!!!!!!!####
  end

  def self.create_home_entries(author, blog_url)
    day = Date.parse('2014-10-07')
    while day <= Date.today do
      days_authors = BLOG_SCHEDULE[day.strftime('%m/%d/%Y')]
      if !days_authors.nil? && days_authors.include?(author)
        entry_date = day.to_date
        if Entry.find_by(date: entry_date).nil?
          entry_title = "visit blog home page"
          entry_url = blog_url
          author_id = Author.find_by(name: author).id
          Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
        end
      end
      day += 1
    end
  end

  def self.create_entries(author, noko_hash, blog_platform)
    if blog_platform == "github"
      if !noko_hash.nil? && !noko_hash["feed"].nil? && !noko_hash["feed"]["entry"].nil?
        noko_hash["feed"].each do |k,v|
          if k == "entry"
            if v.class == Array
              v.each do |entry_hash|
                entry_url = entry_hash["link"]["href"]
                if Entry.find_by(url: entry_url).nil?
                  entry_title = entry_hash["title"]
                  date = entry_hash["updated"]
                  entry_date = date.to_date #converts to DateTime
                  author_id = Author.find_by(name: author).id
                  Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
                else 
                  next
                end
              end
            elsif v.class == Hash 
              entry_url = v["link"]["href"]
              if Entry.find_by(url: entry_url).nil?
                entry_title = v["title"]
                date = v["updated"]
                entry_date = date.to_date #converts to DateTime
                author_id = Author.find_by(name: author).id
                Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
              else 
                next
              end
            end
          end
        end
      end
    
    elsif blog_platform == "ghost"
      if !noko_hash.nil? && !noko_hash["rss"].nil? && !noko_hash["rss"]["channel"].nil? && !noko_hash["rss"]["channel"]["item"].nil?
        noko_hash["rss"]["channel"]["item"].each do |entry_hash|
          entry_url = entry_hash["link"]
          if Entry.find_by(url: entry_url).nil?
            entry_title = entry_hash["title"]
            entry_date = entry_hash["pubDate"]
            author_id = Author.find_by(name: author).id
            Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
          else
            next
          end
        end
      end
    end
  end 

  BlogParser.call
end