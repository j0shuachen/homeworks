class Piece
  attr_reader :color, :opts, :type

  def initialize(color)
    @color = color
    @type = nil
    @opts = {}
  end

  def to_s
    @type.to_s.upcase.colorize(color)
  end

  def valid_move?(start_pos, end_pos, board = nil, previous = nil)
    arr = []
    arr << start_pos[0] - end_pos[0]
    arr << start_pos[1] - end_pos[1]
    self.class.moves.include? arr
  end

  def self.moves
  end

  def ignore_collision?
    false
  end


end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = :puce
    @color_idx = 0
  end

  def colors
    color_arr = []
    4.times { color_arr << :white; color_arr << :black }
    4.times { color_arr << :black; color_arr << :white }
    2.times { color_arr += color_arr }
    color_arr
  end

  def to_s
    @color = colors[@color_idx]
    @color_idx = @color_idx == (colors.size - 1) ? 0 : @color_idx + 1
    '   ' #.colorize(:color => @color, :background => @color)  # (@color)
  end

end

class King < Piece

  def initialize(color)
    @color = color
    @type = :k
  end

  def to_s
    @color == :black ? " ♚ " : " ♔ "
  end

  def valid_move?(start_pos, end_pos, board = nil, previous = nil)
    arr = []
    arr << start_pos[0] - end_pos[0]
    arr << start_pos[1] - end_pos[1]
    self.class.moves.include? arr
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

  def to_s
    @color == :black ? " ♞ " : " ♘ "
  end

  def valid_move?(start_pos, end_pos, board = nil, previous = nil)
    arr = []
    arr << start_pos[0] - end_pos[0]
    arr << start_pos[1] - end_pos[1]
    self.class.moves.include? arr
  end

  def self.moves
    [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[2,-1],[-2,1],[-2,-1]]
  end

  def ignore_collision?
    true
  end

end

class Bishop < Piece
  def intialize(color)
    @color = color
    @type = :h
  end

  def to_s
    @color == :black ? " ♝ " : " ♗ "
  end

  def valid_move?(start_pos, end_pos, board = nil, previous = nil)
    arr = []
    arr << start_pos[0] - end_pos[0]
    arr << start_pos[1] - end_pos[1]
    self.class.moves.include? arr
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

  def to_s
    @color == :black ? " ♜ " : " ♖ "
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

  def valid_move?(start_pos, end_pos, board = nil, previous = nil)
    arr = []
    arr << start_pos[0] - end_pos[0]
    arr << start_pos[1] - end_pos[1]
    self.class.moves.include? arr
  end

  def to_s
    @color == :black ? " ♛ " : " ♕ "
  end

  def self.moves
    Rook.moves + Bishop.moves
  end
end

class Pawn < Piece
  def initialize(color)
    @type = :p
    @color = color
  end

  def to_s
    @color == :black ? " ♟ " : " ♙ "
  end

  def valid_move?(start_pos, end_pos, board, previous)
    moves = [1,0]
    first_move = first(start_pos, end_pos)
    en_pass = en_passant(start_pos, end_pos, board, previous)
    capt = capturing(start_pos, end_pos, board, previous)
    moves += first_move if first_move
    moves += en_pass if en_pass
    moves += capt if capt
    x = end_pos[0] - start_pos[0]
    y = end_pos[1] - start_pos[1]
    moves.include? [x, y]

  end

  def en_passant(start_pos, end_pos, board, previous)
    return false unless previous[type] == :p
    if color == :white
      moves = [[-1,1],[-1,-1]]
      return false unless previous[start_pos][0] == 1
      return false unless previous[end_pos][0] == 3
    else
      moves = [[1,1],[1,-1]]
      return false unless previous[start_pos][0] == 6
      return false unless previous[end_pos][0] == 4
    end
    moves
  end


  def first(start_pos, end_pos, board = nil, previous = nil)
    if color == :white
      moves = [[-2,0]]
      return false unless start_pos[0] == 6
    else
      moves = [[2,0]]
      return false unless start_pos[0] == 1
    end
    moves
  end

  def capturing(start_pos, end_pos, board, previous = nil)
    if color == :white
      moves = [[-1, -1], [-1, 1]]
      return false if board[end_pos].color == :white
    else
      moves = [[1, 1], [1, -1]]
      return false if board[end_pos].color == :black
    end
    moves
  end

end
