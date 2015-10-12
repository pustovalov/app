class MainController < ApplicationController
  
  def index
    @card = Card.expired.random    
  end
  
  def check
    @card = Card.where(original_text: params[:card][:original_text]).take
    user_text = params[:card][:translated_text]
    unless @card.blank?
      @card.update(review_date: Time.zone.today + 3.days)
      if @card.translated_text == user_text
        flash[:notice] = "Правильно"
      else
        flash[:error] = "Не правильно"
      end
    end
    redirect_to action: "index"
  end
end
