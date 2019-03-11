class AddUserToReportedExcuses < ActiveRecord::Migration[5.2]
  def change
    add_reference :reported_excuses, :user, foreign_key: true
  end
end
