class MainController < ApplicationController
  def index
    @card = Card.current_deck.expired.random.presence || Card.expired.random
  end

  def check
    @card = Card.where(original_text: params[:card][:original_text]).take
    translated_text = params[:card][:translated_text]
    check = @card.check_translation(translated_text)
    if check[:success]
      flash[:notice] = t("notifications.correct")
    else
      flash[:error] = %(Wrong:
                         #{ t("main.original_text") }: #{@card.original_text}
                         #{ t("translation") }: #{@card.translated_text}
                         #{ t("main.word_user") }: #{translated_text}
                         #{ t("main.typos") }: #{check[:typos]}
                      )
    end
    redirect_to action: "index"
  end
end
