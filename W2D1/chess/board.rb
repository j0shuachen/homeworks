require 'singleton'
require_relative 'display'
require_relative 'pieces'

class Board
  attr_reader :grid

  def initialize(grid = nil)
    @null_piece = NullPiece.instance
    @grid ||= Array.new(8) { Array.new(8, @null_piece) }

  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def move_piece(start_pos, end_pos)
    mover = @grid[start_pos]
    @grid[start_pos] = @null_piece
    @grid[end_pos] = mover

  end

  def dupe
    arr = []
    @grid.each do |row|
      new_row = []
      row.each do |col|
        new_row << col
      end
      arr << new_row
    end
    arr
  end

  def set_up

  end

end


bored = Board.new
# bored[[0,0]] = 'oijo'
Display.new(bored).render
