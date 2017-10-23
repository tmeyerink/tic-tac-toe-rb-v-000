WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken? (board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  turn_counter = 0
  board.each do |index|
    if index == "X" || index == "O"
      turn_counter += 1
    end
  end
  turn_counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
 puts "Please enter 1-9:"
 input = gets.strip
 index = input_to_index(input)
 character = current_player(board)
 if valid_move?(board,index) 
   move(board, index, character)
   display_board(board)
 else
   turn(board)
 end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_move|
    board[win_move[0]] == board[win_move[1]] && board[win_move[1]] == board[win_move[2]] && position_taken?(board, win_move[0])
  end
end

def full?(board)
  board.each do |position|
    if position == " "
      return false
    end
 end
 true
end

def draw?(board)
  if full?(board) == true && won?(board) == false
    return true
  end
  false
end

def over?(board)
  if won?(board) != false || draw?(board) == true
    return true
  end
  false
end

def winner(board)
  win_combination = won?(board)
  if over?(board) == true && draw?(board) == false
    win_index = win_combination[0]
    letter = board[win_index]
    return letter
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board) != false
    winner = winner(board)
    puts "Congratulations #{winner}!"
  else draw?(board) == true
    puts "Cat's Game!"
  end
end
