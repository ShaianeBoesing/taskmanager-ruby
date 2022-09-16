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
    

end
