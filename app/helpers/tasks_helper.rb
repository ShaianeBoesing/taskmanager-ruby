module TasksHelper
    def filter_tasks(filter_type)
        case filter_type
        when "end"
            @tasks = Task.order_by_end_soon
        when "init"
            @tasks = Task.order_by_init_soon
        when "on"
            @tasks = Task.filter_by_status_on
        when "off"
            @tasks = Task.filter_by_status_off
        else
            @tasks = Task.all
        end
            
        return @tasks.page(params[:page]).per(10).asc
    end
    
end
