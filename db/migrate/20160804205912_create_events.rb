class CreateEvents < ActiveRecord::Migration[5.0]
  class Event20160822 < ActiveRecord::Base
    self.table_name = :events
  end

  class Conference20160822 < ActiveRecord::Base
    self.table_name = :conferences
  end

  def change
    create_table :events do |t|
      t.belongs_to :conference, foreign_key: true, null: false, index: {unique: true}
      t.string   :address, null: false
      t.float    :latitude, null: false
      t.float    :longitude, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false
      t.datetime :call_for_proposals_ends_at, null: false
      t.string   :call_for_proposals_url
      t.boolean  :has_travel_funding
      t.boolean  :has_lodging_funding
      t.boolean  :has_honorariums
      t.boolean  :has_diversity_scholarships
      t.integer  :attendees_count
      t.integer  :submission_opportunities_count
      t.integer  :keynotes_count
      t.integer  :other_talks_count
      t.integer  :panels_count
      t.integer  :plenaries_count
      t.integer  :prior_submissions_count
      t.integer  :talks_count
      t.integer  :tracks_count
      t.integer  :tutorials_count
      t.integer  :workshops_count
      t.timestamps null: false
    end

    reversible do |dir|
      dir.up do
        Conference20160822.find_each do |conference|
          if conference.starts_at.present?
            Event20160822.create!(
              conference_id: conference.id,
              address: conference.location,
              latitude: 0,
              longitude: 0,
              starts_at: conference.starts_at,
              ends_at: conference.ends_at,
              call_for_proposals_ends_at: conference.cfp_deadline,
              call_for_proposals_url: conference.cfp_url,
              has_travel_funding: conference.has_travel_funding,
              has_lodging_funding: conference.has_lodging_funding,
              has_honorariums: conference.has_honorariums,
              has_diversity_scholarships: conference.has_diversity_scholarships,
              attendees_count: conference.attendee_count,
              submission_opportunities_count: conference.cfp_count,
              keynotes_count: conference.keynote_count,
              other_talks_count: conference.other_count,
              panels_count: conference.panel_count,
              plenaries_count: conference.plenary_count,
              prior_submissions_count: conference.prior_submissions_count,
              talks_count: conference.talk_count,
              tracks_count: conference.track_count,
              tutorials_count: conference.tutorial_count,
              workshops_count: conference.workshop_count,
            )
          end
        end
      end

      dir.down do
        Conference20160822.find_each do |conference|
          event = Event20160822.find_by(conference_id: conference.id)
          if event.present?
            conference.update_attributes!(
              starts_at: event.starts_at,
              ends_at: event.ends_at,
              cfp_deadline: event.call_for_proposals_ends_at,
              cfp_url: event.call_for_proposals_url,
              has_travel_funding: event.has_travel_funding,
              has_lodging_funding: event.has_lodging_funding,
              has_honorariums: event.has_honorariums,
              has_diversity_scholarships: event.has_diversity_scholarships,
              attendee_count: event.attendees_count,
              cfp_count: event.submission_opportunities_count,
              keynote_count: event.keynotes_count,
              other_count: event.other_talks_count,
              panel_count: event.panels_count,
              plenary_count: event.plenaries_count,
              prior_submissions_count: event.prior_submissions_count,
              talk_count: event.talks_count,
              track_count: event.tracks_count,
              tutorial_count: event.tutorials_count,
              workshop_count: event.workshops_count,
            )
          end
        end
      end
    end

    remove_column :conferences, :cfp_deadline, :datetime
    remove_column :conferences, :cfp_url, :string
    remove_column :conferences, :has_travel_funding, :boolean
    remove_column :conferences, :has_lodging_funding, :boolean
    remove_column :conferences, :has_honorariums, :boolean
    remove_column :conferences, :has_diversity_scholarships, :boolean
    remove_column :conferences, :starts_at, :datetime
    remove_column :conferences, :ends_at, :datetime
    remove_column :conferences, :attendee_count, :integer
    remove_column :conferences, :cfp_count, :integer
    remove_column :conferences, :keynote_count, :integer
    remove_column :conferences, :other_count, :integer
    remove_column :conferences, :panel_count, :integer
    remove_column :conferences, :plenary_count, :integer
    remove_column :conferences, :prior_submissions_count, :integer
    remove_column :conferences, :talk_count, :integer
    remove_column :conferences, :track_count, :integer
    remove_column :conferences, :tutorial_count, :integer
    remove_column :conferences, :workshop_count, :integer
  end
end
