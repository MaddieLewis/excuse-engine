class CreateReportedExcuses < ActiveRecord::Migration[5.2]
  def change
    create_table :reported_excuses do |t|
      t.string :title
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :category
      t.datetime :time

      t.timestamps
    end
  end
end
