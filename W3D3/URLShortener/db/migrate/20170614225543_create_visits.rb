class CreateVisits < ActiveRecord::Migration[5.0]
  def change
    create_table :visits do |t|
      t.integer :user_id, null: false
      t.integer :shortened_urls_id, null:false
      # t.integer :number_of_visits
      t.timestamps
    end
    add_index :visits, :user_id
    add_index :visits, :shortened_urls_id
  end



end
