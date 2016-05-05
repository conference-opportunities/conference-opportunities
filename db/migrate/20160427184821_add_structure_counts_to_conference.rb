class AddStructureCountsToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :cfp_count, :integer
    add_column :conferences, :keynote_count, :integer
    add_column :conferences, :other_count, :integer
    add_column :conferences, :panel_count, :integer
    add_column :conferences, :plenary_count, :integer
    add_column :conferences, :prior_submissions_count, :integer
    add_column :conferences, :talk_count, :integer
    add_column :conferences, :track_count, :integer
    add_column :conferences, :tutorial_count, :integer
    add_column :conferences, :workshop_count, :integer
  end
end
