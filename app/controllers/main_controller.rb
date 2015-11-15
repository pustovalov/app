class MainController < ApplicationController
  def index
    @card = Card.current_deck.expired.random.presence || Card.expired.random
  end

  def check
    @card = Card.where(original_text: params[:card][:original_text]).take
    translated_text = params[:card][:translated_text]
    check = @card.check_translation(translated_text)
    if check[:success]
      flash[:notice] = "Correct"
    else
      flash[:error] = %(Wrong:
                         Original word: #{@card.original_text}
                         Translation: #{@card.translated_text}
                         You wrote: #{translated_text}
                         Typos: #{check[:typos]}
                      )
    end
    redirect_to action: "index"
  end
end
