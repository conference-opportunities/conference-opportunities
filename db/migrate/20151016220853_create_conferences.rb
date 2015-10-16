class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :twitter_handle
      t.string :logo_url
      t.string :name
      t.string :location
      t.string :website_url
      t.text :description

      t.timestamps null: false
    end
  end
end
