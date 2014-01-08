class Player
  attr_accessor :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def play_turn(board)
    puts "It is #{self.name}'s turn."

    begin
      puts "Enter the start coordinates (for example '1,2')"
      start = gets.chomp.split(",").map{|s| s.to_i}

      puts "Enter the target coordinates"
      finish = gets.chomp.split(",").map{|s| s.to_i}

      board.move(start, finish)
    rescue
      puts "Please enter another move"
      retry
    end
  end
end