require_relative "slidingPiece"

class Bishop < SlidingPiece
  def initialize(board, pos, color)
    @symbol = :b
    @move_dirs = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    super(board, pos, color)
  end
end