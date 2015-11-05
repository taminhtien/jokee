class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.text :content
      t.integer :like, default: 0
      t.integer :dislike, default: 0
    end
  end
end
