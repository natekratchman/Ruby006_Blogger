class BlogsController < ApplicationController
  
  get '/' do
    redirect "/Ruby006_Blogger"
  end

  get '/Ruby006_Blogger' do 
    @entries = Entry.all.where("name is not null")
    @authors = Author.all
    @todays_authors = BLOG_SCHEDULE[Date.today.strftime('%m/%d/%Y')]
    @yesterdays_authors = BLOG_SCHEDULE[(Date.today-1).strftime('%m/%d/%Y')]
    erb :"/index"
  end

  get '/Ruby006_Blogger/all' do
    @entries = Entry.all
    @day = Date.today
    @first_day = Date.parse('2014-10-05')
    erb :"/date_index"
  end

  post '/Ruby006_Blogger/author' do
    user_input = params[:author_name].split.map(&:capitalize).join(" ")
    @author = Author.where("name LIKE (?)","%#{user_input}%")
    if @author.first.nil?
      redirect "/Ruby006_Blogger/author/0"
    else
      redirect "/Ruby006_Blogger/author/#{@author.first.id}"
    end
  end

  get '/Ruby006_Blogger/author/0' do
    @entries = Entry.all
    @authors = Author.all
    @todays_authors = BLOG_SCHEDULE[Date.today.strftime('%m/%d/%Y')]
    @yesterdays_authors = BLOG_SCHEDULE[(Date.today-1).strftime('%m/%d/%Y')]
    erb :"/bad_input"
  end

  get '/Ruby006_Blogger/author/:id' do
    @author = Author.find(params[:id])
    erb :"/author_show"
  end

end