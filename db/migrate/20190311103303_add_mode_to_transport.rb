class AddModeToTransport < ActiveRecord::Migration[5.2]
  def change
    add_column :location_excuses, :transport_mode, :string
  end
end
