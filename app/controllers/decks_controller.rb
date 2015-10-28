class DecksController < ApplicationController
  before_action :find_deck, only: [:update, :destroy, :edit, :current]

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
    redirect_to action: :index
  end

  def find_deck
    @deck = Deck.find(params[:id])
  end

  def current
    Deck.where(current: true).update_all(current: false)
    @deck.current = true
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
