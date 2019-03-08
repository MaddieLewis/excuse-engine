class AddFavoriteToSavedExcuse < ActiveRecord::Migration[5.2]
  def change
    add_column :saved_excuses, :favorite, :boolean, default: false
  end
end
