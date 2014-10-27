class Author < ActiveRecord::Base
  has_many :entries
end