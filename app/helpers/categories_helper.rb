module CategoriesHelper

    def category_name(category)
        category.name.capitalize
    end

    def display_category(appointment)
        link_to category_name(appointment.category), category_path(appointment.category)   
    end
    
end
