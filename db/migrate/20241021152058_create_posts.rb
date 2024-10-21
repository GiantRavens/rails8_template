class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts, id: false do |t|
      t.string :id, primary_key: true
      t.string :title
      t.text :body
      t.boolean :published
      
      t.timestamps
    end
  end
end
