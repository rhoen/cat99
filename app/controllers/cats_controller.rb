class CatsController < ApplicationController

  before_action :logged_in, except: [:index, :show]
  before_action :verify_ownership, only: [:edit, :update]


  def index
    @cats = Cat.all
    render :show
  end

  def show
    @cat = Cat.find(params[:id])
    @requests = @cat.cat_rental_requests
    render :cat
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      render :new
    end

  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat.id)
    else
      render :edit
    end
  end



  private
    def cat_params
      params.require(:cat).permit(:name, :birth_date, :color, :description, :sex)
    end


    def verify_ownership
      @cat = Cat.find(params[:id])
      redirect_to cat_url(@cat.id) unless @cat.user_id == current_user.id
    end




end
