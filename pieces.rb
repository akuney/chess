require 'debugger'

class Piece
  attr_accessor :board, :pos, :color, :symbol

  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
  end

  def moves
  end
end

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
        end

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

class SteppingPiece < Piece
end

class Bishop < SlidingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    self.symbol = :b
  end

  def self.move_dirs
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end

class Rook < SlidingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = :r
    @move_dirs = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end

class Queen < SlidingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    self.symbol = :q
  end

  def self.move_dirs
    Rook.move_dirs + Bishop.move_dirs
  end
end

class Knight < SteppingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    self.symbol = :n
  end
end

class King < SteppingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    self.symbol = :k
  end
end

class Pawn < Piece
  def initialize(board, pos, color)
    super(board, pos, color)
    self.symbol = :p
  end
end