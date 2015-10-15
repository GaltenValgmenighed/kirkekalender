class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :subtitle
      t.string :lead
      t.string :body
      t.datetime :startdate
      t.datetime :enddate

      t.timestamps null: false
    end
  end
end
