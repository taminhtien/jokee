class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.integer :like
    	t.integer :dislike
    	t.references :joke
    end
  end
end
