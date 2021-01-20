class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :name 
      t.datetime :start_time
      t.datetime :end_time
      t.float :price 
      t.integer :customer_id
      t.integer :category_id
      t.integer :user_id 
      t.timestamps
    end
  end
end
