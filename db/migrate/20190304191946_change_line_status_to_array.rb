class ChangeLineStatusToArray < ActiveRecord::Migration[5.2]
  def change
    change_column :location_excuses, :lines_disrupted, :string, array: true, using: "lines_disrupted::character varying[]"
    change_column :location_excuses, :disruption_message, :string, array: true, using: "lines_disrupted::character varying[]"
  end
end
