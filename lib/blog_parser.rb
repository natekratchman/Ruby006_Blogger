class BlogParser

  def self.call
    RSS_URLS.each do |author, author_hash|
      Author.create(name: author) if Author.find_by(name: author).nil?
      
      blog_url = author_hash["url"]
      blog_platform = author_hash["platform"]
      if blog_platform == "home"
        self.create_home_entries(author, blog_url)
      else
        rss_hash = self.get_hash(blog_url) 
        self.create_entries(author, rss_hash, blog_platform)
      end
    end
  end

  def self.get_hash(blog_url)
    rss_hash = RSS::Parser.parse(blog_url)
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

  def self.create_entries(author, rss_hash, blog_platform)
    case blog_platform
    when "github" 
      rss_hash.entries.each do |entry|
        entry_url = entry.link.href
        if Entry.find_by(url: entry_url).nil?
          entry_title = entry.title.content
          entry_date = entry.updated.content
          author_id = Author.find_by(name: author).id
          Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
        else
          next
        end
      end
    when "ghost"
      rss_hash.items.each do |entry|
        entry_url = entry.link
        if Entry.find_by(url: entry_url).nil?
          entry_title = entry.title
          entry_date = entry.pubDate
          author_id = Author.find_by(name: author).id
          Entry.create(title: entry_title, url: entry_url, date: entry_date, author_id: author_id)
        else
          next
        end
      end
    end
  end 

end