class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :type, :limit => 50, :default => ""
      t.string :name, :limit => 50, :default => ""
      t.string :title, :limit => 250, :default => ""
      t.text :content
      t.integer :views, :limit => 12, :default => 0

      t.timestamps
    end

    add_index :posts, :type
    add_index :posts, :title
  end
end
