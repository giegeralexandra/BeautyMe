class Category < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :customers, through: :appointments 

    validates :name, presence: true 
    validates :name, {:length => { :maximum => 12, :minimum => 2}}
    validate :uniqueness_of_category_for_user_only 

    #validations 
    
    def uniqueness_of_category_for_user_only
        current_user = User.find_by(id: self.user_id)
        current_user.categories.each do |category|
            if self.name.capitalize == category.name.capitalize
                errors.add(:name, "cannot be duplicate")
            end
        end
    end

end