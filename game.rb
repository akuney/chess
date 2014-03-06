require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :player1, :player2, :board
  attr_accessor :current_player, :other_player

  def initialize(name1, name2)
    @player1 = Player.new(name1, :w)
    @player2 = Player.new(name2, :b)
    @current_player = self.player1
    @other_player = self.player2
    @board = Board.new

    self.play
  end

  def play
    winner = nil

    loop do
      unless self.board.checkmate?(self.current_player.color)
        self.board.render
        self.current_player.play_turn(self.board)
      else
        winner = self.other_player
        break
      end
      switch_player
    end

    puts "Checkmate! The winner is #{winner.name}."
  end

  def switch_player
    self.current_player, self.other_player =
    self.other_player, self.current_player
  end
end



