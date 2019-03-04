class CreateLocationExcuses < ActiveRecord::Migration[5.2]
  def change
    create_table :location_excuses do |t|
      t.string :start_point
      t.string :end_point
      t.string :lines_disrupted
      t.string :disruption_message

      t.timestamps
    end
  end
end
