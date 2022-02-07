require_relative 'game'
require_relative 'tournament'


tournament = Tournament.new
game = Game.new(tournament)
tournament.first_game(game)
