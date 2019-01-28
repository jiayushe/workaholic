class RemarksController < ApplicationController
  #def new
  #  @item = Item.find(params[:item_id])
  #end

  def create
    @item = Item.find(params[:item_id])
    @remark = @item.remarks.create(remark_params)
    if @remark.save
      redirect_to item_path(@item)
    else
      flash[:danger] = "The following error(s) prohibited this remark from being saved:\n\r ♣ "+ @remark.errors.full_messages.join("\r\n ♣ ")
      redirect_to item_path(@item)
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
