class Piece

  def initialize(color)
    @color = color
    @type = nil
  end

  def to_s
    @type.to_s.upcase.colorize(color)
  end

  def valid_move?(start_pos, end_pos)
    arr = []
    arr << start_pos[0] - end_pos[0]
    arr << start_pos[1] - end_pos[1]
    self.class.moves.include? arr
  end


end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def to_s
    '-'.colorize(:black)
  end

end

class King < Piece

  def initialize(color)
    @color = color
    @type = :k
  end

  def self.moves
    [[0,1],[0,-1],[1,0],[-1,0],[1,1],[-1,-1],[1,-1],[-1,1]]
  end

end

class Knight < Piece
  def initialize(color)
    @color = color
    @type = :h
  end

  def self.moves
    [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
  end

end

class Bishop < Piece
  def intialize(color)
    @color = color
    @type = :h
  end

  def self.moves
    arr = []
    (1..7).each do |i|
      arr << [i, i]
      arr << [-i, i]
      arr << [-i, -i]
      arr << [i, -i]
    end
    arr
  end
end

class Rook < Piece
  def initialize(color)
    @color = color
    @type = :b
  end

  def self.moves
    arr = []
    (1..7).each do |i|
      arr << [0, i]
      arr << [0, -i]
      arr << [i, 0]
      arr << [-i, 0]
    end
  end
end

class Queen < Piece
  def initialize(color)
    @color = color
    @type = :b
  end

  def self.moves
    Rook.moves + Bishop.moves
  end
end
