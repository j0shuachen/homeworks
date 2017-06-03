require '00_tree_node'

class KnightPathFinder

  def initialize(start)
    @start = start
    @move_tree = nil
    @valid_moves = self.valid_moves
    @result = []
    @visited = []
  end




private

  def self.valid_moves
    all_moves = Array.new(8) { Array.new(8) }
    (0..7).each do |i|
      (0..7).each do |j|
        moves = valid_positions(i, j)
        all_moves[i][j] = moves
      end
    end
    all_moves
  end

  def build_move_tree
    node = self.start
  end

  def self.valid_positions(i, j)
    positions = []
    plus = [[2, 1], [1,2], [-2, 1], [-2, -1], [-1, 2], [-1, -2], [1, -2], [2, -1]]
    plus.each do |pair|
      x, y = pair
      if (i+x).between?(0..8) && (j+y).between?(0..8)
        positions << [i+x, j+y]
      end
    end
      positions
  end

end
