class AddAttendeeCountToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :attendee_count, :integer
  end
end
