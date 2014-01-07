class Piece
  attr_accessor :board, :pos

  def initialize(board, pos)
    @board = board
    @pos = pos
  end

  def moves
  end
end

class SlidingPiece < Piece
  attr_accessor :move_dirs

  def initialize
    super(board, pos)
    @move_dirs = self.class.move_dirs
  end
end

class SteppingPiece < Piece
end

class Bishop < SlidingPiece

  def self.move_dirs
    [[1, 1], [1, -1], [-1, 1], [-1, -1]]
  end
end

class Rook < SlidingPiece

  def self.move_dirs
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end

class Queen < SlidingPiece

  def self.move_dirs
    Rook.move_dirs + Bishop.move_dirs
  end
end

class Knight < SteppingPiece
end

class King < SteppingPiece
end