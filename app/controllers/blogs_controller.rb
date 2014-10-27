class BlogsController < ApplicationController

  get '/' do
    redirect "/Ruby006_Blogs"
  end

  get '/Ruby006_Blogs' do 
    @entries = Entry.all
    @authors = Author.all
    erb :"/index"
  end

  get '/Ruby006_Blogs/:id' do
    @author = Author.find(params[:id])
    erb :"/show"
  end

end