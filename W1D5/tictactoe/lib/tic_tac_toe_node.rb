require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @previous_move_pos = prev_move_pos

  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    array =[]
    (0..@board.length-1).each do |i|
      (0..@board[0].length-1).each do |j|
        if @board.empty?([i,j])
          duped = @board.dup
          duped.place_mark([i,j])
          next_mover_mark = next_mover_mark == :x ? :o : :x
          TicTacToeNode.new(board.dup, next_mover_mark, prev_move_pos)
        end
      end
    end

    end

=begin
    @board.each_with_index do |row, idx|
      row.each_with_index do |col, idx2|
        array << [idx, idx2] unless @board[idx][idx2]
      end
    end
=end
    array
  end


end
