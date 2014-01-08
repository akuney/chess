require_relative 'piece'

class SteppingPiece < Piece
  attr_accessor :move_dirs

  def moves
    possible_moves = []
    self.move_dirs.each do |dir|

      next_x = self.pos[0] + dir[0]
      next_y = self.pos[1] + dir[1]

      next if !next_x.between?(0,7) || !next_y.between?(0,7)

      if self.board[next_x, next_y].nil?
        possible_moves << [next_x, next_y]
      else
        unless self.color == self.board[next_x, next_y].color
          possible_moves << [next_x, next_y]
        end
      end

    end

    possible_moves
  end

end