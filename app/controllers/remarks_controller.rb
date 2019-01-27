class RemarksController < ApplicationController
# http_basic_authenticate_with name:"user", password:"passwd", only: :destroy
  #def new
  #  @item = Item.find(params[:item_id])
  #end

  def create
    @item = Item.find(params[:item_id])
    @remark = @item.remarks.create(remark_params)
    if @remark.save
      redirect_to item_path(@item)
    else
      redirect_to item_path(@item)
      #render 'new'
    end
  end
  
  def destroy
    @item = Item.find(params[:item_id])
    @remark = @item.remarks.find(params[:id]) 
    @remark.destroy
    redirect_to item_path(@item)
  end

  private
    def remark_params
      params.require(:remark).permit(:body, :date)
    end
end
