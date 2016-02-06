class AddApprovedAtToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :approved_at, :datetime
  end
end
