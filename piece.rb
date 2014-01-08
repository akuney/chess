class Piece
  attr_accessor :board, :pos, :color, :symbol, :display_symbol

  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    @display_symbol = (self.color.to_s + self.symbol.to_s).to_sym
  end

  def moves
  end

  def valid_moves
    candidate_targets = self.moves
    candidate_targets.delete_if { |target| self.move_into_check?(target) }
    candidate_targets
  end

  def opposite_color
    self.color == :w ? :b : :w
  end

  def move_into_check?(target)
    duped_board = self.board.dup
    duped_board.move!(self.pos, target)

    duped_board.in_check?(self.color)
  end
end
