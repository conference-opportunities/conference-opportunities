class DeviseCreateConferenceOrganizers < ActiveRecord::Migration
  def change
    create_table(:conference_organizers) do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.belongs_to :conference, null: false
      t.timestamps null: false
    end

    add_index :conference_organizers, [:provider, :uid], unique: true
    add_index :conference_organizers, :conference_id, unique: true
  end
end
