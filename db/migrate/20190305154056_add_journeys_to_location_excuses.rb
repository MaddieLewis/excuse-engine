class AddJourneysToLocationExcuses < ActiveRecord::Migration[5.2]
  def change
    add_column :location_excuses, :journeys, :string, array: true
  end
end
