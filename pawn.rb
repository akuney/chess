require_relative 'piece'

class Pawn < Piece
  attr_accessor :forward_dir, :diag_dirs, :starting_row

  def initialize(board, pos, color)
    @symbol = :p
    super(board, pos, color)
    @forward_dir = get_forward
    @diag_dirs = get_diags
    @starting_row = get_starting_row
  end

  def get_forward
    self.color == :w ? [0, 1] : [0, -1]
  end

  def get_diags
    self.color == :w ? [[1, 1], [-1, 1]] : [[1, -1], [-1, -1]]
  end
  def get_starting_row
    self.color == :w ? 1 : 6
  end

  def moves
    possible_moves = []

    forward_one = [self.pos[0], self.pos[1] + self.forward_dir[1]]
    forward_two = [self.pos[0], self.pos[1] + 2 * self.forward_dir[1]]

    if self.board[forward_one].nil?
      possible_moves << forward_one

      if self.pos[1] == self.starting_row && self.board[forward_two].nil?
        possible_moves << forward_two
      end
    end

    self.diag_dirs.each do |diag|
      new_pos = [self.pos[0] + diag[0], self.pos[1] + diag[1]]

      if self.board[new_pos]
        possible_moves << new_pos if self.board[new_pos].color == self.opposite_color
      end
    end

    possible_moves
  end
end
