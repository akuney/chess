load 'pieces.rb'
load 'board.rb'

b = Board.new(false)

b[7,0] = Rook.new(b, [7,0], :w)
b[6,1] = Rook.new(b, [6,1], :w)
b[2,2] = King.new(b, [2,2], :b)

king = b[2,2]

b.render
puts
puts king.move_into_check?([1,0])
puts
puts king.valid_moves.display
puts
puts b.checkmate?(:b)

#
# puts b[1,1].moves.inspect
# puts b[1,1].move_into_check?([2,2])
# puts b[1,1].valid_moves.inspect
# b.render
#
