class GameOfLife
  attr_accessor :board, :neighborhood

  def initialize(size)
    @size = size
    @board = Array.new(size){Array.new(size)} 
    @neighborhood  = Array.new(size){Array.new(size)}
  end

  def create_board_randomly
    size.times do |row|
      size.times do |col|
        board[row][col] = ['_', '1'].sample
        neighborhood[row][col] = 0
      end
    end
  end

  def show_board
    board.each { |elem| puts "#{elem}" }
  end

  def show_neighborhood
    neighborhood.each { |elem| puts "#{elem}" }
  end

  def next_state(values = (1..size-2).to_a)
    values.each do |row|
      values.each { |col| rules(row, col) }
    end
  end

  def rules(row, col, counter = 0)
    counter += 1 unless board[row-1][col] == '_'
    counter += 1 unless board[row-1][col-1] == '_'
    counter += 1 unless board[row-1][col+1] == '_'
    counter += 1 unless board[row][col-1] == '_'
    rules_sequel(counter, row, col)
  end

  def rules_sequel(counter, row, col)
    counter += 1 unless board[row][col+1] == '_'
    counter += 1 unless board[row+1][col-1] == '_'
    counter += 1 unless board[row+1][col+1] == '_'
    counter += 1 unless board[row+1][col] == '_'

    neighborhood[row][col] = counter
  end

  def find_life
    size.times do |row|
      size.times { |col| board[row][col] = still_alive?(row, col) ? '1' : '_' }
    end  
  end

  private
    attr_reader :size
    def still_alive?(row, col)
      neighborhood[row][col] == 2 || neighborhood[row][col] == 3
    end

    game = GameOfLife.new(10)
    puts "\nFirst board state"
    game.create_board_randomly
    game.show_board
    game.next_state
    
    puts "\nNumber of neighbors of each cell"
    game.show_neighborhood
    
    puts "\nNext board state"
    game.find_life
    game.show_board
end