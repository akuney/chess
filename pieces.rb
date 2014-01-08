require 'debugger'

class Piece
  attr_accessor :board, :pos, :color, :symbol

  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    @display_symbol = (self.color.to_s + self.symbol.to_s).to_sym
  end

  def moves
  end

  def valid_moves
    candidate_targets = self.moves
    candidate_targets.delete_if{|target| self.move_into_check?(target)}
    candidate_targets
  end

  def opposite_color
    self.color == :w ? :b : :w
  end

  def move_into_check?(target)
    duped_board = self.board.dup
    duped_board.move!(self.pos, target)

    duped_board.in_check?(self.color)
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

class Bishop < SlidingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = :b
    @move_dirs = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
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
    @symbol = :q
    @move_dirs = [[1, 1], [1, -1], [-1, 1], [-1, -1],
    [1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end

class Knight < SteppingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = :n
    @move_dirs = [
      [2,1],
      [2,-1],
      [1,2],
      [1,-2],
      [-1,2],
      [-1,-2],
      [-2,1],
      [-2,-1]
    ]
  end
end

class King < SteppingPiece
  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = :k
    @move_dirs = [
      [1,1 ],
      [1, 0],
      [1, -1],
      [0, 1],
      [0, -1],
      [-1, 1],
      [-1, 0],
      [-1,-1]
    ]
  end
end

class Pawn < Piece
  attr_accessor :forward_dir, :diag_dirs, :starting_row

  def initialize(board, pos, color)
    super(board, pos, color)
    @symbol = :p
  end

  def moves
    possible_moves = []

    forward_one = [self.pos[0], self.pos[1] + self.forward_dir[1]]
    forward_two = [self.pos[0], self.pos[1] + 2 * self.forward_dir[1]]

    if self.board[forward_one[0], forward_one[1]].nil?
      possible_moves << forward_one

      if self.pos[1] == self.starting_row &&
        self.board[forward_two[0], forward_two[1]].nil?

        possible_moves << forward_two
      end
    end

    self.diag_dirs.each do |diag|
      new_pos = [self.pos[0] + diag[0], self.pos[1] + diag[1]]

      if self.board[new_pos[0], new_pos[1]]
        if self.board[new_pos[0], new_pos[1]].color == self.opposite_color
          possible_moves << new_pos
        end
      end
    end

    possible_moves
  end


end

class WhitePawn < Pawn
  def initialize(board, pos)
    super(board, pos, :w)
    @forward_dir = [0,1]
    @diag_dirs = [[1,1], [-1,1]]
    @starting_row = 1
  end

end

class BlackPawn < Pawn
  def initialize(board, pos)
    super(board, pos, :b)
    @forward_dir = [0,-1]
    @diag_dirs = [[1,-1], [-1,-1]]
    @starting_row = 6
  end

end