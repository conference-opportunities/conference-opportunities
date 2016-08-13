class AddBannerUrlToConference < ActiveRecord::Migration[5.0]
  def change
    change_table(:conferences) do |t|
      t.string :banner_url
    end
  end
end
