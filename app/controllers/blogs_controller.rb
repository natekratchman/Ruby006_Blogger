class BlogsController < ApplicationController
  
  get '/' do 
    @entries = Entry.all.where("name is not null")
    @authors = Author.all
    @todays_authors = BLOG_SCHEDULE[Date.today.strftime('%m/%d/%Y')]
    @yesterdays_authors = BLOG_SCHEDULE[(Date.today-1).strftime('%m/%d/%Y')]
    erb :"/index"
  end

  get '/all' do
    @entries = Entry.all
    @day = Date.today
    @first_day = Date.parse('2014-10-05')
    erb :"/date_index"
  end

  post '/all' do
    BlogParser.call
    Update.create(update_time: Time.now)
    redirect "/all"
  end

  post '/' do
    BlogParser.call
    Update.create(update_time: Time.now)
    redirect "/"
  end

  post '/author' do
    user_input = params[:author_name].split.map(&:capitalize).join(" ")
    @author = Author.where("name LIKE (?)","%#{user_input}%")
    if @author.first.nil?
      redirect "/author/0"
    else
      redirect "/author/#{@author.first.id}"
    end
  end

  get '/author/0' do
    @entries = Entry.all
    @authors = Author.all
    @todays_authors = BLOG_SCHEDULE[Date.today.strftime('%m/%d/%Y')]
    @yesterdays_authors = BLOG_SCHEDULE[(Date.today-1).strftime('%m/%d/%Y')]
    erb :"/bad_input"
  end

  get '/author/:id' do
    @author = Author.find(params[:id])
    erb :"/author_show"
  end

end