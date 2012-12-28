class DishesController < ApplicationController
  def vote
    dish = Dish.find(params[:id])
    logger.info params[:vote].chomp("\.js").to_sym
    current_user.vote(dish, :up) unless current_user.voted?(dish)
    respond_to do |format|
      format.js{render :json => {:result => "success", :dish_id=>dish.id.to_s}, :layout => false}
    end

  end
end
