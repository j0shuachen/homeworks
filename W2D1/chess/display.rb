require 'colorize'
require_relative 'cursor'
require 'byebug'
class Display

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render(board)
    until @cursor.start_pos && @cursor.end_pos
      system('clear')
      board_temp = Board.new(board.dupe)
      @cursor.value = board_temp[@cursor.cursor_pos]
      board_temp[@cursor.cursor_pos] = @cursor
      puts ''
      board_temp.grid.each_index do |i|
        rowz = []
        board_temp.grid[i].each_index do |j|
          background = (i.even? == j.even?) ? :white : :black
          opts = {}
          opts[:color] = board_temp.grid[i][j].color
          opts[:background] = background
          # opts.merge(board_temp[i][j].opts) if board_temp[i][j].class == Cursor
          rowz << board_temp.grid[i][j].to_s.colorize(opts)
        end
        puts "#{rowz.join}"
      end
      @cursor.get_input
    end
    move = [@cursor.start_pos, @cursor.end_pos]
    @cursor.start_pos = nil
    @cursor.end_pos = nil
    move
  end



end
