desc "notification about expired cards for heroku"
task pending_cards: :environment do
  User.pending_cards
end