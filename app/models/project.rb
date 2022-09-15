class Project < ApplicationRecord
    has_many :tasks, dependent: :delete_all
    validates_presence_of :name, :init, :end
    validate :end_is_valid
    validate :init_is_valid


    scope :asc, -> { order("projects.init ASC") }   
    
    def end_is_valid
        if self.end
            errors.add(:end, "não pode ser menor que a data inicial") unless self.end >= self.init
        end
    end

    def init_is_valid
        if self.init
            errors.add(:init, "não pode ser menor que a data atual") unless self.init >= Date.current
        end
    end

end
