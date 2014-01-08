require_relative 'slidingPiece'

class Rook < SlidingPiece
  def initialize(board, pos, color)
    @symbol = :r
    @move_dirs = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    super(board, pos, color)
  end
end