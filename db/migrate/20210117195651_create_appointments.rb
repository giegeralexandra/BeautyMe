class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :appointment_time
      t.integer :duration
      t.float :price 
      t.integer :customer_id
      t.integer :category_id
      t.integer :user_id 
    end
  end
end
