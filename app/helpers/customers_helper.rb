module CustomersHelper

    def customer_name(customer)
        customer.first_name.capitalize + " " + customer.last_name.capitalize
    end

    def number(customer)
        number_to_phone(customer.phone_number)
    end

end
