require_relative 'steppingPiece'

class King < SteppingPiece
  def initialize(board, pos, color)
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
    super(board, pos, color)
  end
end