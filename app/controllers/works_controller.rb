class WorksController < ApplicationController
  before_filter :authentcate_user!, only: [:new, :create, :edit, :update]
  def index
    if params[:days]
      @works = Work.all.recent_works(params[:days]).order_by_time.paginate(page: params[:page])
    else
      @works = Work.all.order_by_time.paginate(page: params[:page])
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
    @work.user = current_user
    uploaded_io = params[:work][:doc]

    if uploaded_io
      File.open(Rails.root.join("public", "uploads", uploaded_io.original_filename), 'wb') do |file|
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
    @work.user = current_user
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
