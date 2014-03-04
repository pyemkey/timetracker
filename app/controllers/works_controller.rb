class WorksController < ApplicationController
  def index
    if params[:days]
      @works = Work.all.recent_works(params[:days]).order_by_time
    else
      @works = Work.all.order_by_time
    end
  end

  def show
    @work = Work.find(params[:id])
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(secure_params)
    uploaded_io = params[:doc]

    if params[:doc]
      File.open(Rails.root.join("public", "uploads", uploaded_io.original_filename), 'wb') do |file|
        raise
        file.write(uploaded_io.read)
        @work.doc = uploaded_io.original_filename
      end
    end

    if @work.save
      Usermailer.send_info_about_work(@work).deliver
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update_attributes(secure_params)
      redirect_to @work, notice: "Update succesfull"
    else
      redirect_to edit_work_path(@work), alert: "Something goes wrong"
    end
  end
  private
    def secure_params
      params.require(:work).permit(:project_id, :user_id, :date_time_performed, :hours)
    end
end
