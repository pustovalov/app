class MainController < ApplicationController
  def index
    @card = Card.current_deck.expired.random.presence || Card.expired.random
  end

  def check
    @card = Card.where(original_text: params[:card][:original_text]).take
    translated_text = params[:card][:translated_text]
    @card.update(review_date: Time.zone.today + 3.days)
    if @card.check_translation(translated_text)
      flash[:notice] = "Correct"
    else
      flash[:error] = "Wrong"
    end
    redirect_to action: "index"
  end
end
