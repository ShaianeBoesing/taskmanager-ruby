class Task < ApplicationRecord
    belongs_to :project
    validates_presence_of :name, :init, :end, :project_id
    validate :end_is_valid
    validate :init_is_valid

    scope :asc, -> { order("tasks.init ASC") }
    scope :filter_by_project, -> (project) { where project_id: project }
    scope :filter_by_status_on, -> { where status: true }
    scope :filter_by_status_off, -> { where status: false }
    scope :order_by_end_soon, -> { order(end: :asc) }
    scope :order_by_init_soon, -> { order(init: :asc) }

    def init_is_valid
        if self.init
            errors.add(:init, "não pode ser menor que a data atual") unless self.init >= Date.current
            errors.add(:init, "não pode ser menor que a data inicial do projeto") unless self.init >= self.project.init 
        end
    end

    def end_is_valid
        if self.end
            errors.add(:end, "não pode ser menor que a data inicial") unless self.end >= self.init
            errors.add(:end, "não pode ser maior que a data final do projeto") unless self.end <= self.project.end 
        end
    end


end
