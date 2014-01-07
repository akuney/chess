require_relative 'board'

b = Board.new

white_king = b.find_king(:w)

b.in_check?(:w)

