class MainController < ApplicationController
  def index
    @card = find_card
  end

  def find_card
    Card.current_deck.expired.random.presence || Card.expired.random
  end

  def check
    @card = Card.where(original_text: params[:card][:original_text]).take
    translated_text = params[:card][:translated_text]
    time = params[:card][:time]
    check = @card.check_translation(translated_text, time)

    respond_to do |format|
      card = find_card.blank? ? t("zero_cards") : find_card
      if check[:success]
        flash[:success] = t("notifications.correct")
        format.json { render json: { ok: true, notice: flash[:success], type: bootstrap_class_for("success"), card: card } }
        format.html do
          redirect_to action: "index"
        end
      else
        flash[:error] = %(#{t('wrong')}:
                     #{t('main.original_text')}: #{@card.original_text}
                     #{t('translation')}: #{@card.translated_text}
                     #{t('main.word_user')}: #{translated_text}
                     #{t('main.typos')}: #{check[:typos]}
                  )

        format.json { render json: { ok: false, notice: flash[:error], type: bootstrap_class_for("error"), card: card } }
        format.html do
          redirect_to action: "index"
        end
      end
    end
  end
end
