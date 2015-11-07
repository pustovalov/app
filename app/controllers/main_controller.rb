class MainController < ApplicationController
  def index
    @card = Card.current_deck.expired.random.presence || Card.expired.random
  end

  def check
    @card = Card.where(original_text: params[:card][:original_text]).take
    @check = Check.find_or_create_by(card_id: @card.id)
    translated_text = params[:card][:translated_text]
    if @card.check_translation(translated_text)
      flash[:notice] = "Correct"
      @check.mark_correct!
    else
      flash[:error] = "Wrong"
      @check.mark_incorrect!
    end
    redirect_to action: "index"
  end
end
