class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :title 
      t.time :start_time
      t.time :end_time
      t.date :date
      t.float :price 
      t.integer :customer_id
      t.integer :category_id
      t.integer :user_id 
      t.timestamps
    end
  end
end
