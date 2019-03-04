class CreateSavedExcuses < ActiveRecord::Migration[5.2]
  def change
    create_table :saved_excuses do |t|
      t.references :user, foreign_key: true
      t.text :message
      t.integer :rating
      t.references :excuse, polymorphic: true, index: true

      t.timestamps
    end
  end
end
