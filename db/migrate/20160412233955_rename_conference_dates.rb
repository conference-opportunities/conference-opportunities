class RenameConferenceDates < ActiveRecord::Migration
  class Conference20160412 < ActiveRecord::Base
    self.table_name = :conferences
  end

  def change
    add_column :conferences, :starts_at, :datetime
    add_column :conferences, :ends_at, :datetime

    reversible do |dir|
      dir.up do
        Conference20160412.find_each do |conference|
          conference.update_columns(
            starts_at: conference.begin_date,
            ends_at: conference.end_date,
          )
        end
      end

      dir.down do
        Conference20160412.find_each do |conference|
          conference.update_columns(
            begin_date: conference.starts_at,
            end_date: conference.ends_at
          )
        end
      end
    end

    remove_column :conferences, :begin_date, :date
    remove_column :conferences, :end_date, :date
  end
end
