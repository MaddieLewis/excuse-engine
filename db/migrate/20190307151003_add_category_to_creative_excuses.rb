class AddCategoryToCreativeExcuses < ActiveRecord::Migration[5.2]
  def change
    add_column :creative_excuses, :category, :string
  end
end
