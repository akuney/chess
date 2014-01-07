require_relative 'board'

b = Board.new
d = b.dup
d[4,1] = nil
d[4,5] = Rook.new(b, [4,5], :b)
d.move([7,6],[7,5])
puts 'board b'
b.render
puts
puts 'd board'
d.render