class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end


  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_rental_request_url(@request.id)
    else
      render :new
    end
  end


  def show
    @request = CatRentalRequest.find(params[:id])
    @cat = @request.cat
    render :request
  end

  def index
    @requests = CatRentalRequest.all.order(cat_id: :asc).order(start_date: :desc)
    render :show
  end


  def update
  end

  def edit
  end

  def destroy
  end

  private
  def request_params
    params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id, :status)
  end


end
