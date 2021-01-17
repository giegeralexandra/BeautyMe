Customer
- belongs_to :user 
- has_many :appointments
- has_many :categories, through :appointments 

User
- has_many :customers
- has_many :appointments
- has_many :categories

Appointment
- belongs_to :customer
- belongs_to :user

Location
- has_many :appointments 
- belongs_to :user 
- has_many :customers, through :appointments 

