class DecksController < ApplicationController
  before_action :find_deck, only: [:update, :destroy, :edit]

  def index
    @decks = Deck.all.order(:id)
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params.merge(user: current_user))

    if @deck.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    @deck.destroy

    redirect_to decks_path
  end

  def find_deck
    @deck = Deck.find(params[:id])
  end

  def current
    @current_deck = Deck.current.take
    @deck = Deck.find(params[:deck])
    if @current_deck
      @current_deck.current = false
      @current_deck.save
    end
    @deck.current = true
    @deck.save
    if !@deck.save
      flash[:error] = "Something wrong"
    end
    redirect_to decks_path
  end

private

  def deck_params
    params.require(:deck).permit(:name, :current)
  end
end
