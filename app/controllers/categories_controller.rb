class CategoriesController < ApplicationController
  def index
    if params[:search]
      @categories = current_user.categories.search(params[:search])
    else
      @categories = current_user.categories.all.sort
    end
  end

  def show
    @category = current_user.categories.find(params[:id])  
#   render json: current_user.categories.names.to_a if params[:id] == "all"
  end

  def new
    @category = current_user.categories.new
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      @category.assign_items(params[:item], current_user)
      redirect_to @category
    else
      flash.now[:danger] = @category.errors.full_messages.join(", ")
      render 'new', status: :bad_request
    end
  end

  def update
    @category = current_user.categories.find params[:id]
    @category.assign_items(params[:item], current_user)
    if @category.update(category_params)
      redirect_to @category
    else
      flash.now[:danger] = @category.errors.full_messages.join(", ")
      render 'edit', status: :bad_request
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    redirect_to categories_path if @category.destroy
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
