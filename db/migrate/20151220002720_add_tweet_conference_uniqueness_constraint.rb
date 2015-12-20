class AddTweetConferenceUniquenessConstraint < ActiveRecord::Migration
  def change
    add_index :tweets, %i[conference_id twitter_id], unique: true
    remove_index :tweets, [:conference_id]
  end
end
