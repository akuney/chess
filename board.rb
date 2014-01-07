class Board

  def initialize
    @rows = Board.blank_grid
    populate_board
  end

  def self.blank_grid
    Array.new(8) { Array.new(8) { nil } }
  end

  def populate_board
    white_rook_positions = [[0,0], [0,7], [7,0], [7,7]]
    knight_positions = [[1,0], [6,0], [1,7], [6,7]]
    bishop_positions = [[2,0], [5,0], [2,7], [5,7]]
    queen_positions = [[3,0], [3,7]]
    king_positions = [[4,0], [4,7]]

    (0..7).each do |x|
      (0..7).each do |y|
        if rook_positions.include?([x,y])
          self[x,y]
      end
    end
  end


  def [](x, y)
    self.rows[y][x]
  end
end