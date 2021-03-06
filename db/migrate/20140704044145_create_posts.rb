class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :type, :null => false, :limit => 50, :default => ""
      t.string :category, :null => false, :limit => 100, :default => "default"
      t.string :user_id, :null => false, :limit => 30, :default => "Anonymous"
      t.string :name, :null => false, :limit => 50, :default => ""
      t.string :email, :null => false, :limit => 100, :default => ""
      t.string :phone, :null => false, :limit => 25, :default => ""
      t.string :title, :null => false, :limit => 250, :default => ""
      t.text :content, :null => false
      t.integer :views, :null => false, :limit => 12, :default => 0
      t.integer :total_comments, :null => false, :limit => 12, :default => 0

      t.timestamps
    end

    add_index :posts, :type
    add_index :posts, :name
    add_index :posts, :title
  end
end
