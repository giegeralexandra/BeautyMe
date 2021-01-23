module CustomersHelper

    def customer_name(customer)
        customer.first_name.capitalize + " " + customer.last_name.capitalize
    end

    def number(customer)
        number_to_phone(customer.phone_number)
    end

    def display_customer(appointment)
        link_to customer_name(appointment.customer), customer_path(appointment.customer)   
    end

end
