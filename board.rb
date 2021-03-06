require_relative 'piece'

require_relative 'slidingPiece'
require_relative 'steppingPiece'

require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'

require_relative 'king'
require_relative 'knight'

require_relative 'pawn'


class Board
  attr_accessor :rows, :pieces

  def initialize(populate = true)
    @rows = Board.blank_grid
    populate_board if populate
  end

  def self.blank_grid
    Array.new(8) { Array.new(8) { nil } }
  end

  def populate_board
    make_pieces(:w)
    make_pieces(:b)
  end

  def make_pieces(color)
    piece_row = (color == :w ? 0 : 7)
    pawn_row = (color == :w ? 1 : 6)

    (0..7).each do |x|
      pos = [x,piece_row]
      pawn_pos = [x, pawn_row]

      case x
      when 0, 7
        self[pos] = Rook.new(self, pos, color)
      when 1, 6
        self[pos] = Knight.new(self, pos, color)
      when 2, 5
        self[pos] = Bishop.new(self, pos, color)
      when 3
        self[pos] = Queen.new(self, pos, color)
      when 4
        self[pos] = King.new(self, pos, color)
      end

      self[pawn_pos] = Pawn.new(self, pawn_pos, color)
    end
  end

  def render
    display_board = [(0..7).to_a.map { |i| "#{i.to_s} "}]

    self.rows.each do |row|
      display_row = row.map{|piece| piece.nil? ? '__' : piece.display_symbol}
      display_board << display_row
    end

    display_board.each_with_index do |row, i|
      i == 0 ? (print '  ') : (print "#{i - 1} ")
      row.each { |square| print "#{square} " }
      puts
    end
  end

  def []=(pos, piece)
    self.rows[pos[1]][pos[0]] = piece
  end

  def [](pos)
    self.rows[pos[1]][pos[0]]
  end

  def all_pieces(color)
    pieces = []

    self.rows.flatten.compact.each do |piece|
      pieces << piece if piece && piece.color == color
    end

    pieces
  end

  def find_king_coords(color)
    self.rows.flatten.compact.each do |piece|
      return piece.pos if piece.class == King && piece.color == color
    end
  end

  def in_check?(color)
    opposite_color = ( (color == :w) ? :b : :w)
    opposing_pieces = all_pieces(opposite_color)
    king_coords = find_king_coords(color)

    opposing_pieces.each do |piece|
      return true if piece.moves.include?(king_coords)
    end

    false
  end

  def move!(start, finish)
    self[finish] = self[start]
    self.delete(start)
    self[finish].pos = finish
  end

  def move(start, finish)
    if self[start].nil?
      raise "That is not a valid start position"
    end

    unless self[start].moves.include?(finish)
      raise "Your piece can't go there"
    end

    if self[start].move_into_check?(finish)
      raise "That move puts you in check!"
    end

    self[finish] = self[start]
    self.delete(start)
    self[finish].pos = finish
  end

  def delete(pos)
    self[pos] = nil
  end

  def dup
    duped_board = Board.new(false)
    pieces = all_pieces(:b) + all_pieces(:w)

    pieces.each do |piece|
      duped_board[piece.pos] = piece.class.new(duped_board, piece.pos, piece.color)
    end

    duped_board
  end #need to alter if we make single Pawn class

  def checkmate?(color)
    cant_move = all_pieces(color).all? { |piece| piece.valid_moves.empty? }
    in_check?(color) && cant_move
  end
end