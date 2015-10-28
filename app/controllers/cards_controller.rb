class CardsController < ApplicationController

  before_action :check_deck, only: [:create, :update]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params.merge(user: current_user, deck: @deck))

    if @card.save
      redirect_to cards_path
    else
      render "new"
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params.merge(deck: @deck))
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def check_deck
    @deck = Deck.find_by(id: params[:card][:deck])
    if !@deck
      flash[:error] = "Deck can't be blank"
      redirect_to new_card_path
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end

private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :image, :deck)
  end
end
