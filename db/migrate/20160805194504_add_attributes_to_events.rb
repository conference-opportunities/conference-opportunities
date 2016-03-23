class AddAttributesToEvents < ActiveRecord::Migration[5.0]
  class Event20160805 < ActiveRecord::Base
    self.table_name = :events
  end

  def change
    change_table(:events) do |t|
      t.string :hashtag
      t.string :code_of_conduct_url
      t.boolean :has_childcare
      t.datetime :speaker_notifications_at
    end

    reversible do |dir|
      dir.up do
        Event20160805.where(speaker_notifications_at: nil).update_all('speaker_notifications_at = starts_at')
      end
    end

    change_column_null :events, :speaker_notifications_at, false
  end
end
