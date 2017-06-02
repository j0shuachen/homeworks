class Stack

  def initialize
    @ivar = []
  end

  def add(el)
    @ivar << el
    el
  end

  def remove
    @ivar.pop
  end

  def show
    @ivar.dup
  end

end


class Queue

  def initialize
    @queue = []

  def enqueue(el)
    @queue << el
  end

  def dequeue
    @queue.shift
  end

  def show
    @queue.dup
  end

end


class Map

  def initialize
    @map = []
  end



end
