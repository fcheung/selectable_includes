require 'test_helper'

class SelectableIncludesTest < Test::Unit::TestCase
  
  def test_select
    posts = Post.find :all, :include => :comments, :order => 'comments.created_at desc',
          :select => "(SELECT COUNT(*) from favourite_posts where posts.id = favourite_posts.post_id) as favourite_count"

    assert_equal posts(:welcome), posts.first
    assert_equal '2', posts.first.favourite_count
    assert posts.first.comments.loaded?

    assert_equal comments(:other_on_welcome).attributes, posts.first.comments.first.attributes
  end
end