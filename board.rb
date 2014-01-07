require "./pieces"

class Board
  attr_accessor :rows, :pieces

  def initialize
    @rows = Board.blank_grid
    populate_board
  end

  def self.blank_grid
    Array.new(8) { Array.new(8) { nil } }
  end


  def populate_board
    rook_positions = [[0,0], [0,7], [7,0], [7,7]]
    knight_positions = [[1,0], [6,0], [1,7], [6,7]]
    bishop_positions = [[2,0], [5,0], [2,7], [5,7]]

    # white pieces
    (0..7).each do |x|
      if rook_positions.include?([x,0])
        self[x,0] = Rook.new(self, [x, 0], :w)
      elsif knight_positions.include?([x,0])
        self[x,0] = Knight.new(self, [x, 0], :w)
      elsif bishop_positions.include?([x, 0])
        self[x,0] = Bishop.new(self, [x, 0], :w)
      end
    end
    self[3,0] = Queen.new(self, [3, 0], :w)
    self[4,0] = King.new(self, [4, 0], :w)

    #making all pawns
    (0..7).each do |x|
      self[x,1] = Pawn.new(self, [x, 1], :w)
      self[x,6] = Pawn.new(self, [x, 6], :b)
    end

    (0..7).each do |x|
      if rook_positions.include?([x,7])
        self[x,7] = Rook.new(self, [x, 7], :b)
      elsif knight_positions.include?([x,7])
        self[x,7] = Knight.new(self, [x, 7], :b)
      elsif bishop_positions.include?([x, 7])
        self[x,7] = Bishop.new(self, [x, 7], :b)
      end
    end
    self[3,7] = Queen.new(self, [3, 7], :b)
    self[4,7] = King.new(self, [4, 7], :b)

  end

  def render
    display_board = []

    self.rows.each do |row|
      display_row = row.map{|piece| piece.nil? ? nil : piece.symbol}
      display_board << display_row
    end

    display_board.each do |row|
      puts row.inspect
    end
  end

  def [](x, y)
    self.rows[y][x]
  end
end