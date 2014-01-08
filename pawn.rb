require_relative 'piece'

class Pawn < Piece
  attr_accessor :forward_dir, :diag_dirs, :starting_row

  def initialize(board, pos, color)
    @symbol = :p
    super(board, pos, color)
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

end #make only one pawn class

class BlackPawn < Pawn
  def initialize(board, pos)
    super(board, pos, :b)
    @forward_dir = [0,-1]
    @diag_dirs = [[1,-1], [-1,-1]]
    @starting_row = 6
  end

end