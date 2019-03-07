class AddCoordinatesToLocationExcuses < ActiveRecord::Migration[5.2]
  def change
    add_column :location_excuses, :start_latitude, :float
    add_column :location_excuses, :start_longitude, :float
    add_column :location_excuses, :end_latitude, :float
    add_column :location_excuses, :end_longitude, :float
  end
end
