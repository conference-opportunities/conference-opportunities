class AddUnfollowedAtToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :unfollowed_at, :datetime
  end
end
