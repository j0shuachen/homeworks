require_relative 'cursor'
require_relative 'board'
require_relative 'pieces'
require_relative 'display'

class Game

  def initialize
    @board = Board.new
    @turn = :white
    @check = false
    @previous ={}
  end

  def play_game
    until @check == [:white, :black].reject { |x| x == @turn }
      play_turn
    end

  end


  def play_turn
    turn = @turn
    while turn == @turn
      start_pos, end_pos = get_move
      @board.move_piece(start_pos, end_pos)
      @board.previous[:start_pos] = start_pos
      @board.previous[:end_pos] = end_pos
      @board.previous[:type] = @board[end_pos].type
      @board.previous[:taken] = @board[end_pos]
      if check_checker == @turn
        @board.move_piece(end_pos, start_pos)
        @board[end_pos] = @board.previous[taken]
      else
        @turn = @turn == :white ? :black : :white
      end
    end
    check_checker

  end

  def get_move
    move = Display.new(@board).render(@board)
    start_pos, end_pos = move
    until @board.legal?(start_pos, end_pos)
      puts "Invalid move"
      move = Display.new(@board).render(@board)
      start_pos, end_pos = move
    end
    return move
  end

  def check_checker
    black_king = ''
    white_king = ''
    @board.grid.each_index do |row|
      @board.grid[row].each_index do |col|
        if @board[[row,col]].type == :k && @board[[row,col]].color == :black
          black_king = [row, col]
        elsif @board[[row,col]].type == :k && @board[[row,col]].color == :white
          white_king = [row, col]
        end
      end
    end
    @board.grid.each_index do |row|
      @board.grid[row].each_index do |col|
        if @board[[row,col]].color == :white &&
          @board.legal?([row, col], black_king)
          @check = :black
        elsif @board[[row,col]].color == :black &&
          @board.legal?([row,col], white_king)
          @check = :white
        end
      end
    end
  end


end


game = Game.new
game.play_game
