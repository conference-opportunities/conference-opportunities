class CreateOrganizerConferences < ActiveRecord::Migration
  class Organizer20160325 < ActiveRecord::Base
    self.table_name = :organizers
  end

  class OrganizerConference20160325 < ActiveRecord::Base
    self.table_name = :organizer_conferences
  end

  def change
    create_table :organizer_conferences do |t|
      t.belongs_to :organizer, index: {unique: true}, foreign_key: true, null: false
      t.belongs_to :conference, index: {unique: true}, foreign_key: true, null: false

      t.timestamps null: false
    end

    change_column_null :organizers, :conference_id, true

    reversible do |dir|
      dir.up do
        Organizer20160325.find_each do |organizer|
          OrganizerConference20160325.create!(
            organizer_id: organizer.id,
            conference_id: organizer.conference_id
          )
        end
      end
      dir.down do
        OrganizerConference20160325.find_each do |organizer_conference|
          Organizer20160325
            .where(id: organizer_conference.organizer_id)
            .update_all(conference_id: organizer_conference.conference_id)
        end
      end
    end

    remove_index :organizers, column: [:conference_id], unique: true
    remove_column :organizers, :conference_id, :integer
  end
end
