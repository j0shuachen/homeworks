class AddDescriptionToSubs < ActiveRecord::Migration[5.0]
  def change
    add_column :subs, :description, :text, null: false
  end
end
