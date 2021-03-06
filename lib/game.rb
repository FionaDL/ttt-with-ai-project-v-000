require 'pry'

class Game

  attr_accessor :board, :player_1, :player_2

  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

 def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
   @player_1 = player_1
   @player_2 = player_2
   @board = board
 end

  def current_player
   board.turn_count.even? ? player_1 : player_2
  end

  def won?
    WIN_COMBINATIONS.find do |combo|
      if @board.cells[combo[0]] != " " && @board.cells[combo[0]] == @board.cells[combo[1]] && @board.cells[combo[1]] == @board.cells[combo[2]]
        combo
      else
        false
      end
    end
  end

  def draw?
     self.won? == nil && @board.full? == true ? true : false
  end

  def over?
    won? || @board.full?
  end

  def winner
    if !won?
      nil
    elsif @board.cells[won?[0]] == "X"
      "X"
    else @board.cells[won?[0]] == "O"
      "O"
    end
  end

  def turn
    puts "What is your move #{current_player.token}?"
    the_move = current_player.move(@board)
    if !@board.valid_move?(the_move)
      "That is not a valid move!"
      turn
    else
    @board.update(the_move, current_player)
    @board.display
    end
  end

  def play
    turn until over? || draw?
    if over? && winner == "X"
      puts "Congratulations X!"
    elsif over? && winner == "O"
      puts "Congratulations O!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

end
