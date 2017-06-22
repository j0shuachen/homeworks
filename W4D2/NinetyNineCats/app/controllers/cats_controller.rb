class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      render :show
    else
      render json: @cat.errors.full_messages, status: 400
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = find_cat
    render :edit
  end

  def show
    @cat = find_cat

    if @cat
      render :show
    else
      render json: "No such cat", status: 400
    end
  end

  def update
    @cat = find_cat
    if @cat.update_attributes(cat_params)
      render :show
    else
      render json: @cat.errors.full_messages, status: 400
    end
  end

  def destroy
    @cat = find_cat
    if @cat
      @cat.destroy
      render :index
    else
      render json: "No such cat exists", status: 404
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :age, :birth_date, :description)
  end

  def find_cat
    Cat.find_by(id: params[:id])

  end
end
