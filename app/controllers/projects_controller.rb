class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @projects = Project.all
    respond_to do |format|
      format.html
      format.csv { send_data Project.export_csv(@projects), type: 'text/csv; charset=utf-8; header-present;', disposition: 'attachment; filename=contacts.csv'}
    end
  end

  def show
    if params[:slug]
      @project = Project.find_by slug: params[:slug]
    else
      @project = Project.find(params[:id])
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(secure_params)
    if @project.save
      redirect_to root_path, notice: "Project was created"
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(secure_params)
      Usermailer.update_project(@project).deliver
      redirect_to @project, notice: "Update succesfull"
    else
      redirect_to edit_project_path(@project), alert: "Something goes wrong"
    end
  end
  private
    def secure_params
      params.require(:project).permit(:name, :slug, :default_rate, :company_id)
    end
end
