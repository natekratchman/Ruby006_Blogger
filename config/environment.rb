ENV['SINATRA_ENV'] ||= "development"

require 'net/http'
require 'bundler/setup'
require 'date'
require 'open-uri'
require 'rss'

Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'
require_all 'lib'