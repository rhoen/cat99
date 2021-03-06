class CatRentalRequestsController < ApplicationController

  before_action :logged_in, except: [:show, :index]
  before_action :verify_ownership, only: [:approve, :deny]


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
      @cats = Cat.all
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @request.approve!
    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @request.deny!
    redirect_to cat_url(@request.cat_id)
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


  def verify_ownership
    @cat = Cat.find(params[:id])
    redirect_to cat_url(@cat.id) unless @cat.user_id == current_user.id
  end

end
