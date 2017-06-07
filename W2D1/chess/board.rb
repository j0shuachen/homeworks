require 'singleton'
require_relative 'display'
require_relative 'pieces'

class Board
  attr_reader :grid
  attr_accessor :previous

  def initialize(grid = nil)
    @previous = {}
    @null_piece = NullPiece.instance
    @grid ||= Array.new(8) { Array.new(8, @null_piece) }
    set_up
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

    mover = self[start_pos]
    self[start_pos] = @null_piece
    self[end_pos] = mover

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
    @grid[1].each_index do |i|
      @grid[1][i] = Pawn.new(:black)
    end
    @grid[6].each_index do |i|
      @grid[6][i] = Pawn.new(:white)
    end
    @grid[0].each_index do |idx|
      if idx == 0 || idx == 7
        @grid[0][idx] = Rook.new(:black)
      elsif idx == 1 || idx == 6
        @grid[0][idx] = Knight.new(:black)
      elsif idx == 2 || idx == 5
        @grid[0][idx] = Bishop.new(:black)
      elsif idx == 3
        @grid[0][idx] = Queen.new(:black)
      else
        @grid[0][idx] = King.new(:black)
      end
    end
    @grid[7].each_index do |idx|
      if idx == 0 || idx == 7
        @grid[7][idx] = Rook.new(:white)
      elsif idx == 1 || idx == 6
        @grid[7][idx] = Knight.new(:white)
      elsif idx == 2 || idx == 5
        @grid[7][idx] = Bishop.new(:white)
      elsif idx == 4
        @grid[7][idx] = Queen.new(:white)
      else
        @grid[7][idx] = King.new(:white)
      end
    end
  end

  def collision?(start_pos, end_pos)
    if start_pos[1] > end_pos[1]
      delta_x = (end_pos[1] + 1...start_pos[1]).to_a
    elsif start_pos[1] < end_pos[1]
      delta_x = (start_pos[1] + 1...end_pos[1])
    else
      delta_x = [start_pos[1]]
    end
    if start_pos[0] > end_pos[0]
      delta_y = (end_pos[0] + 1...start_pos[0]).to_a
    elsif start_pos[0] < end_pos[0]
      delta_y = (start_pos[0] + 1...end_pos[0])
    else
      delta_y = [start_pos[0]]
    end
    delta_x.each do |col|
      delta_y.each do |row|
        return true unless @grid[row][col].class == @null_piece
      end
    end
    false
  end

  def legal?(start_pos, end_pos)
    return false if collision?(start_pos, end_pos)
    return false if self[start_pos].color == self[end_pos].color
    return false unless self[start_pos].valid_move?(start_pos, end_pos, self, @previous)
    true
  end


end
