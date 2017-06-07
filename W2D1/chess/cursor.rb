require 'io/console'
require 'colorize'

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board, :color, :opts
  attr_accessor :value, :start_pos, :end_pos

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @value = nil
    @start_pos = nil
    @end_pos = nil
    @opts = {}
    @opts[:background] = :red
  end

  def get_input
    begin
      key = KEYMAP[read_char]
      handle_key(key)
    rescue
      retry
    end
  end

  def to_s
    @color = :red
    @value.to_s.colorize(:background => :red)
  end
  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :return || :space
      if @start_pos
        @end_pos = @cursor_pos.dup
      else
        @start_pos = @cursor_pos.dup
      end

    when MOVES.keys.select { |k| k == key }[0]
      @cursor_pos[0] += MOVES[key][0]
      @cursor_pos[1] += MOVES[key][1]

    else
      return :pppppp
    end
  end

  def update_pos(diff)
  end
end
