require_relative 'steppingPiece'

class Knight < SteppingPiece
  def initialize(board, pos, color)
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
    super(board, pos, color)
  end
end