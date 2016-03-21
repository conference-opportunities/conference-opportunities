class RenameConferenceOrganizerToOrganizer < ActiveRecord::Migration
  def change
    rename_table :conference_organizers, :organizers
  end
end
