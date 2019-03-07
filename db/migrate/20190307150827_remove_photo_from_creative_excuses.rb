class RemovePhotoFromCreativeExcuses < ActiveRecord::Migration[5.2]
  def change
    remove_column :creative_excuses, :photo
  end
end
