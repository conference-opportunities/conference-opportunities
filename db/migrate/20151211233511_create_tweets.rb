class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :conference, null: false
      t.string :twitter_id, null: false
      t.timestamps null: false
    end
    add_index :tweets, :conference_id
  end
end
