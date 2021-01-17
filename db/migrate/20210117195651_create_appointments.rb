class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :appointment_time
      t.integer :appointment_length
      t.integer :customer_id
      t.integer :stylist_id
    end
  end
end
