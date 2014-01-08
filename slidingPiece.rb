require_relative 'piece'

class SlidingPiece < Piece
  attr_accessor :move_dirs

  #need to finish this
  def moves
    possible_moves = []

    self.move_dirs.each do |dir|
      num_steps = 1

      loop do

        next_step = [dir[0]*num_steps, dir[1]*num_steps]
        next_pos = [self.pos[0] + next_step[0], self.pos[1] + next_step[1]]

        if !next_pos[0].between?(0,7) || !next_pos[1].between?(0,7)
          break
        end #refactor with .all?

        # if there is something in the next_pos square
        unless self.board[next_pos[0], next_pos[1]].nil?
          other_piece_color = self.board[next_pos[0], next_pos[1]].color

          if self.color == other_piece_color
            break
          else
            possible_moves << next_pos
            break
          end

        else
          possible_moves << next_pos
          num_steps += 1
        end

      end
    end

    possible_moves
  end
end