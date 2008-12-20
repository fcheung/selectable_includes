class Post < ActiveRecord::Base
  has_many :comments
  has_many :favourite_posts
end