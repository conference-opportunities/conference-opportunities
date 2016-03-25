class UpdateConferenceUidToBeNullFalse < ActiveRecord::Migration
  def change
    change_column_null :conferences, :uid, false
  end
end
