ActiveRecord::Schema.define(:version => 0) do
  create_table :posts, :force => true do |t|
    t.datetime :created_at
  end

  create_table :comments, :force => true do |t|
    t.integer :post_id
    t.datetime :created_at
  end

  create_table :users, :force => true do |t|
    t.string :name
  end
  
  create_table :favourite_posts, :force => true do |t|
    t.integer :post_id    
    t.integer :user_id    
  end

end