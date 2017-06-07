require 'byebug'

class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) {Array.new}
    place_stones
    @name1 = name1
    @name2 = name2

  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |x, idx|
      next if idx == 6 || idx == 13
      4.times do
        x << :stone
      end
    end

  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if start_pos > 13 || start_pos < 0
    raise 'Invalid starting cup' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    idx = start_pos
    until stones.empty?
      idx+=1
      idx = 0 if idx > 13
      if idx == 6
        @cups[idx] << stones.pop if current_player_name == @name1
      elsif idx == 13
        @cups[idx] << stones.pop if current_player_name == @name2
      else
        @cups[idx] << stones.pop
      end
    end
    render
    next_turn(idx)



  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].length == 1
      return :switch
    else
      return ending_cup_idx
    end

  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    side1 = (0...6).to_a
    side2 = (7..12).to_a
    s1 = side1.none? {|x| @cups[x].length > 0}
    s2 = side2.none? {|y| @cups[y].length > 0}
    s1|| s2


    # side1 = []
    # side2 =[]
    # (0...6).each do |x|
    #   side1 << @cups[x]
    # end
    # (7..13).each do |y|
    #   side2 << @cups[y]
    # end
    # return true if side1.all? {|x| x.empty?}
    # return true if side2.all? {|y| y.empty?}
    # false
  end

  def winner
    p1 = @cups[6].count
    p2 = @cups[13].count
    if p1 == p2
      :draw
    else
      p1 >p2 ? @name1 : @name2
    end
  end

end

x= Board.new("josh","john")
x.make_move(1,"josh")
