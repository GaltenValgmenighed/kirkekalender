class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :ics_url
      t.string :name
      t.string :info_url

      t.timestamps null: false
    end
  end
end
