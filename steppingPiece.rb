require_relative 'piece'

class SteppingPiece < Piece
  attr_accessor :move_dirs

  def moves
    possible_moves = []
    self.move_dirs.each do |dir|
      next_pos = [(self.pos[0] + dir[0]), (self.pos[1] + dir[1])]

      next unless next_pos.all? { |i| i.between?(0,7) }

      if self.board[next_pos].nil?
        possible_moves << next_pos
      else
        unless self.color == self.board[next_pos].color
          possible_moves << next_pos
        end
      end
    end

    possible_moves
  end

end