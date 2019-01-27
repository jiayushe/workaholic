class ItemsController < ApplicationController
# http_basic_authenticate_with name:"user", password:"passwd", except:[:index, :show]

  def index
    if params[:search]
      @items = current_user.items.search(params[:search])
    else
      @items = current_user.items.all
    end
    @items = @items.order(sort_column + " " + sort_direction)  
  end
  
  def show
#   render json: current_user.items.names.to_a if params[:id] == "all"
    @item = current_user.items.find(params[:id])
  end

  def new
    @item = current_user.items.new
  end
 
  def edit
    @item = current_user.items.find(params[:id])
  end

  def create
    @item = current_user.items.new(item_params)  
    if @item.save
      @item.assign_categories(params[:category], current_user)    
      redirect_to @item
    else
      flash.now[:danger] = @item.errors.full_messages.join(",")
      render 'new', status: :bad_request
    end
    #render plain: params[:item].inspect
  end

  def update
    @item = current_user.items.find(params[:id])
    @item.assign_categories(params[:category], current_user)
    if @item.update(item_params)
      redirect_to @item
    else
      flash.now[:danger] = @item.errors.full_messages.join(",")
      render 'edit', status: :bad_request
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy
 
    redirect_to items_path
  end

  private
    def item_params
      params.require(:item).permit(:title, :details, :deadline, :level_of_importance)
    end
 
    # Level_of_importance is the default column sorting mode
    def sort_column
      if current_user.items.column_names.include?(params[:sort])
        params[:sort]
      else
        "level_of_importance"
      end
    end

    # Ascending is the default direction sorting mode
    def sort_direction
      if %w[asc desc].include?(params[:direction])
        params[:direction]
      else
        "asc"
      end
    end

    # Helper method to generate table header in View
    def sortable(column, title = nil)
      title ||= column.titleize
      title += "<i class=\"fa fa-sort-#{sort_direction}\"></i>" if column == sort_column
      direction =
        if column == sort_column && sort_direction == "asc"
          "desc"
        else
          "asc"
        end
      [title.html_safe, sort: column, direction: direction]
    end

    helper_method :sortable
end
