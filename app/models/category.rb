class Category < ApplicationRecord
    belongs_to :user 
    has_many :appointments
    has_many :customers, through: :appointments 

    validates :name, presence: true 
    validates :name, {:length => { :maximum => 12, :minimum => 2}}
    validate :uniqueness_of_category_per_user 

    #validations 
    
    def uniqueness_of_category_per_user
        current_user = User.find_by(id: self.user_id)
        current_user.categories.each do |category|
            if category != self 
                if self.name.capitalize == category.name.capitalize
                    errors.add(:name, "cannot be duplicate")
                end
            end
        end
    end

end