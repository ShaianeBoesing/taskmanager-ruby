class Project < ApplicationRecord
    has_many :tasks, dependent: :delete_all
    validates_presence_of :name, :init, :end
    validate :end_is_valid
    validate :init_is_valid, on: :create
    validate :new_init_is_valid, on: :update
    validate :tasks_arent_out_project_period, on: :update

    scope :asc, -> { order(init: :asc) }   


    def end_is_valid
        if self.end
            errors.add(:end, "can't be earlier than start date") unless self.end >= self.init
        end
    end

    def init_is_valid
        if self.init && self.end
            errors.add(:init, "can't be earlier than today") unless self.init >= Date.current
        end
    end

    def new_init_is_valid
        if self.init && self.end
            if self.changed
                errors.add(:init, "can't be earlier than last reported date") unless self.init_was <= self.init
            end
        end
    end

    def tasks_arent_out_project_period
        if self.init && self.end
            task = self.tasks.select(:init, :end).order(init: :asc).first
            if task
                errors.add(:init, "can't be greater than task's init dates") unless task.init >= self.init
                errors.add(:end, "can't be earlier than task's end dates") unless task.end <= self.end
            end
        end
    end
end
