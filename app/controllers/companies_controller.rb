class CompaniesController < ApplicationController
  def index
    @companies = Company.all    
  end

  def show
    @company = Company.find(params[:id])
    respond_to do |format|
      format.html 
      format.xml   { render xml: @company }
      format.json  { render json: @company }
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(secure_params)
    if @company.save
      redirect_to root_path, notice: "Companies was created"
    else
      render :new
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(secure_params)
      redirect_to @company, notice: "Update succesfull"
    else
      redirect_to edit_company_path(@company), alert: "Something goes wrong"
    end
  end

  private
    def secure_params
      params.require(:company).permit(:name)
    end
end

