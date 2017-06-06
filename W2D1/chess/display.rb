require 'colorize'
require_relative 'cursor'
require 'byebug'
class Display

  def initialize(board)
    @cursor = Cursor.new([0,0], board)
    @board = board
  end

  def render
    until @cursor.start_pos && @cursor.end_pos
      board_temp = Board.new(@board.dupe)
      @cursor.value = board_temp[@cursor.cursor_pos]
      board_temp[@cursor.cursor_pos] = @cursor
      puts ''
      board_temp.grid.each do |row|
        rowz = row.map { |i| i.to_s }.join(" ")
        puts rowz
      end
      input = @cursor.get_input
    end
    @board.move_piece(@cursor.start_pos, @cursor.end_pos)
    @cursor.start_pos = nil
    @cursor.end_pos = nil
  end



end
