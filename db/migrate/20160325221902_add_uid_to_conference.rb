class AddUidToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :uid, :string
    add_index :conferences, :uid, unique: true
  end
end
