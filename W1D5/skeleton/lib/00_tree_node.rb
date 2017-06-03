require 'byebug'

class PolyTreeNode

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    if self.parent
      @parent.children.delete(self)
    end
    @parent = node
    if node
      node.children.push(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'not a child node' unless self.children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |c|
      res = c.dfs(target_value)
      return res if res
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue.concat(node.children)
    end
    nil
  end

end


if __FILE__ == $PROGRAM_NAME
  n1 = PolyTreeNode.new("root1")
  n2 = PolyTreeNode.new("root2")
  n3 = PolyTreeNode.new("root3")

  # connect n3 to n1
  n3.parent = n2
  # connect n3 to n2
  n2.parent = n1

  # debugger
  n1.bfs("root3")

end
