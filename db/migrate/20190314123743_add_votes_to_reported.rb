class AddVotesToReported < ActiveRecord::Migration[5.2]
  def change
    add_column :reported_excuses, :votes, :integer, default: 0
  end
end
