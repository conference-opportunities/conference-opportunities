class AddLocaleToOrganizer < ActiveRecord::Migration
  def change
    add_column :organizers, :locale, :string, null: false, default: "en"
  end
end
