class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_projects, only: %i[ edit new create update]
  before_action :task_params, only: %i[ create update ]
  before_action :set_filter, only: %i[ index search ]

  # GET /tasks or /tasks.json
  def index
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    
    @task = Task.new(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: "Task was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Task was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    project_id = params[:project_id]
    @project = Project.find(project_id)
    @tasks = @tasks.filter_by_project(project_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :init, :end, :status, :project_id)
    end

    def set_projects
      if params[:project_id]
        @projects = Project.find([params[:project_id]])
      else
        @projects = Project.all
      end
    end

    def set_filter
      @filters = [
                  ["Done", :on], 
                  ["Not done", :off], 
                  ["Starts soon", :init], 
                  ["Ends soon", :end]
                ]

      @filter = params[:filter]
      @tasks = helpers.filter_helper(@filter)
            
    end
  end