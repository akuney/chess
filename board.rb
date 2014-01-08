require "./pieces"

class Board
  attr_accessor :rows, :pieces

  def initialize(populate = true)
    @rows = Board.blank_grid
    populate_board if populate == true
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
      self[x,1] = WhitePawn.new(self, [x, 1])
      self[x,6] = BlackPawn.new(self, [x, 6])
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
      display_row = row.map{|piece| piece.nil? ? nil : piece.display_symbol}
      display_board << display_row
    end

    display_board.each do |row|
      puts row.inspect
    end
  end

  def []=(x, y, piece)
    self.rows[y][x] = piece
  end

  def [](x,y)
    self.rows[y][x]
  end

  def all_pieces(color)
    pieces = []

    self.rows.each do |row|
      row.each do |piece|
        pieces << piece if !piece.nil? && piece.color == color
      end
    end

    pieces
  end

  def find_king(color)
    self.rows.each do |row|
      row.each do |piece|
        return piece if piece.class == King && piece.color == color
      end
    end
  end

  def in_check?(color)
    opposite_color = ( (color == :w) ? :b : :w)
    opposing_pieces = all_pieces(opposite_color)

    king_coords = find_king(color).pos

    opposing_pieces.each do |piece|
      return true if piece.moves.include?(king_coords)
    end

    false
  end

  def move!(start, finish)
    self[finish[0], finish[1]] = self[start[0], start[1]]
    self.delete(start)
    self[finish[0], finish[1]].pos = [finish[0], finish[1]]
  end

  def move(start, finish)
    if self[start[0], start[1]].nil?
      raise "That is not a valid start position"
    end

    unless self[start[0], start[1]].moves.include?(finish)
      raise "Your piece can't go there"
    end

    if self[start[0], start[1]].move_into_check?(finish)
      raise "That move puts you in check!"
    end

    self[finish[0], finish[1]] = self[start[0], start[1]]
    delete(start)
    self[finish[0], finish[1]].pos = [finish[0], finish[1]]
  end

  def delete(pos)
    self[pos[0], pos[1]] = nil
  end

  def dup
    duped_board = Board.new(false)

    pieces = all_pieces(:b) + all_pieces(:w)

    pieces.each do |piece|
      if piece.class != BlackPawn && piece.class != WhitePawn
        duped_board[piece.pos[0], piece.pos[1]] =
        piece.class.new(duped_board, piece.pos, piece.color)
      elsif piece.class == BlackPawn
        duped_board[piece.pos[0], piece.pos[1]] =
        BlackPawn.new(duped_board, piece.pos)
      elsif piece.class == WhitePawn
        duped_board[piece.pos[0], piece.pos[1]] =
        WhitePawn.new(duped_board, piece.pos)
      end
    end

    duped_board
  end

  def checkmate?(color)
    cant_move = all_pieces(color).all? { |piece| piece.valid_moves.empty? }
    in_check?(color) && cant_move
  end
end