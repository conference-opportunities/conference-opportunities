class RequireConferenceTwitterHandle < ActiveRecord::Migration
  def change
    change_column_null :conferences, :twitter_handle, false
    add_index :conferences, :twitter_handle, unique: true
  end
end
