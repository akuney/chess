require_relative 'board'

b = Board.new
b[4,1] = nil
b[4,5] = Rook.new(b, [4,5], :b)

#b.move([1,1], [1,2])
b.move([3,0],[4,1])
b.render