class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.text :content
    end
  end
end
