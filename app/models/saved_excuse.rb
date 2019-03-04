class SavedExcuse < ApplicationRecord
  belongs_to :user
  belongs_to :excuse, polymorphic: true
end
