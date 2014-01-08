require_relative 'slidingPiece'

class Queen < SlidingPiece
  def initialize(board, pos, color)
    @symbol = :q
    @move_dirs = [[1, 1], [1, -1], [-1, 1], [-1, -1],
    [1, 0], [-1, 0], [0, 1], [0, -1]]
    super(board, pos, color)
  end
end