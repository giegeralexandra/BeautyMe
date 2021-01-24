# README

Hi, welcome to the BeautyMe Rails Application! Using this application will provide users (stylists, beauticians, salons, etc) with a website to create, read, update and delete appointments, customers and categories. Users will own a combination of objects(customers, appointments,categories) and are provided with the ability to convinently organize their schedules.  

## Installation

Execute:

    $ bundle install

Once gems are installed, execute:

    $ rails db:migrate

Once migrations are completed, execute:

    $ rails s

Proceed to your browser and enter http://localhost:3000/

## Usage

Once the homepage is successfully loaded in browser, user must login, login with Facebook or signup. 

If user already owns an account, please click Login to continue. If user is new to website, please click Signup to continue or choose the Facebook login option. 

If user is already logged in, the browser will redirect you to the home page. This page is a month view of a calendar with appointments listed on each day. 

User may select an appointment to view the details. If user would like to edit or delete the appointments, user must go to the appointment show page and click 'edit appointment' or 'delete appointment'. User may only view, edit or delete an appointment the user created. 

When logged in, user will have navigation links at the top of the webpage to provide additional options. 'Upcoming Appointments' link will present the user to a page with appointments for the current week. 'Profile' will present the user with a profile page and an option to edit the account information. 'New Appointment' link will present the user with a form to create a new appointment, category and customer. 'Categories' and 'Customers' will show the user a list of their categories and customers. 'New Category' and 'New Customer' allow the user to create a single category or customer. 'Logout' link will destroy the current session and return to index home page. 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/<github username>/beauty-me.


## License

The is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

