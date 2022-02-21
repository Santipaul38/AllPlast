class PagesController < ApplicationController
  def home
  end

  def stock
   if params[:product_id] and params[:quantity] 
    @prod = Product.where(:id => params[:product_id]).first
    @stock = @prod.stock + params[:quantity].to_i
    @prod.update(:stock => @stock)
    @prod.update(:max_stock => @stock)
    redirect_to pages_stock_url(product_id: params[:product_id])
   end
  end
end
