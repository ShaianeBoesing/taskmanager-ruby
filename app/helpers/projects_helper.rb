module ProjectsHelper
    def filter_projects(filter_type)
        case filter_type
        when "end"
            @projects = Project.order_by_end_soon
        when "init"
            @projects = Project.order_by_init_soon
        else
            @projects = Project
        end
            
        return @projects.page(params[:page]).per(10).asc
    end
    
    def calculate_completed(project)
        completed = 0.0
        done = project.tasks.where(:status => :true).count.to_f
        total = project.tasks.count.to_f
        if total > 0
            completed = (done / total)* 100
        end
        completed
    end

    def percentual_format(value, decimal_houses)
        value.round(decimal_houses).to_s + "%"
    end
    
end
