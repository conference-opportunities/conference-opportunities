class AddTweetsCountToConference < ActiveRecord::Migration[5.0]
  class Tweet20160819 < ActiveRecord::Base
    self.table_name = :tweets
  end

  class Conference20160819 < ActiveRecord::Base
    self.table_name = :conferences
  end

  def change
    change_table(:conferences) do |t|
      t.integer :tweets_count, default: 0, null: false
    end

    reversible do |dir|
      dir.up do
        Conference20160819.find_each do |conference|
          conference.update_attributes!(
            tweets_count: Tweet20160819.where(conference_id: conference.id).count
          )
        end
      end
    end
  end
end
