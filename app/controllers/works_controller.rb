class WorksController < ApplicationController
  def index
    if params[:days]
      @works = Work.all.recent_works(params[:days]).order('date_time_performed DESC')
    else
      @works = Work.all
    end
  end

  def show
    @work = Work.find(params[:id])
  end
end
