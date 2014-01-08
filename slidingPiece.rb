require_relative 'piece'

class SlidingPiece < Piece
  attr_accessor :move_dirs

  #need to finish this
  def moves
    possible_moves = []

    self.move_dirs.each do |dir|
      num_steps = 1
      blocked = false

      until blocked
        next_step = [dir[0]*num_steps, dir[1]*num_steps]
        next_pos = [self.pos[0] + next_step[0], self.pos[1] + next_step[1]]

        blocked = true unless next_pos.all? { |i| i.between?(0,7) }

        if self.board[next_pos]
          blocked = true
          piece_color = self.board[next_pos].color
          possible_moves << next_pos unless self.color == piece.color
        else
          possible_moves << next_pos
          num_steps += 1
        end
      end
    end

    possible_moves
  end
end