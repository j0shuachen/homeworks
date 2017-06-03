require_relative '00_tree_node'

class KnightPathFinder
  PLUS = [[2, 1], [1,2], [-2, 1], [-2, -1], [-1, 2], [-1, -2], [1, -2], [2, -1]]

  def initialize(start)
    @start = start
    # @move_tree = build_move_tree
    @visited = [start]
    @result = [start]

  end

# private

=begin
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
=end

  def valid_moves(pos)
    x, y = pos
    moves = []
    PLUS.each do |pair|
      i, j = pair
      if (i+x).between?(0, 8) && (j+y).between?(0, 8)
        moves << [i+x, j+y]
      end
    end
    moves
  end

  def new_move_positions(pos)
    moves = valid_moves(pos)
    new_moves = moves.reject { |coor| @visited.include?(coor) }
    @visited.concat(new_moves) #new_moves is an array
    # puts "visited positions: #{@visited}"
    new_moves
  end

  def build_move_tree
    root = PolyTreeNode.new(@start)
    queue = [root]
    until queue.empty?
      curr = queue.shift
      # puts "got node at #{curr.value}"
      moves = new_move_positions(curr.value)
      moves.each do |pos|
        # puts "setting node on position #{pos}"
        node = PolyTreeNode.new(pos)
        node.parent = curr
        queue.push(node)
      end
    end
    root
  end

  def trace_path_back(end_node)
    path = []
    curr = end_node
    while curr.parent
      path.unshift(curr.value)
      curr = curr.parent
    end
    path.unshift(@start)
    path
  end

  def find_path(end_pos)
    root = build_move_tree
    end_node = root.bfs(end_pos)
    trace_path_back(end_node)
  end

end

if __FILE__ == $PROGRAM_NAME
  path_finder = KnightPathFinder.new([0, 0])
  p path_finder.find_path([8, 8])
end
