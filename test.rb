require_relative 'board'

b = Board.new
b[4,1] = nil
b[4,5] = Rook.new(b, [4,5], :b)
b.move([4,5], [3,4])

