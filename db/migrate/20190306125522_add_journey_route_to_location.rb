class AddJourneyRouteToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :location_excuses, :journey_route, :string, array: true
    change_column :location_excuses, :lines_disrupted, :string
    change_column :location_excuses, :disruption_message, :string
  end
end
