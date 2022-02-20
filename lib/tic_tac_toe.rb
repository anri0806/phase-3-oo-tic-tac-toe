require 'pry'

class TicTacToe

    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]
    ]

    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
    end

    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        board[index] = token
    end

    # true = occpupied, false = free
    def position_taken?(index)
        board[index] == " " ? false : true
    end

    def valid_move?(index)
        !position_taken?(index) && (0..8).include?(index)
    end

    def turn_count
        board.length - board.count(" ")
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end
    
    def turn
        puts "please enter a number (1-9)"

        input = gets.strip
        index = input_to_index(input)
        player = current_player
        
        if valid_move?(index)
            move(index, player)
            display_board
        else
            self.turn
        end
    end

    def won?
        # return true if all 3 board matches 
        WIN_COMBINATIONS.any? {|combo|
        # if positions is occupied && all 3 board[index] matches
        if position_taken?(combo[0]) && board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]]   
            return combo
        end
        }
    end

    def full?
        # (0..8).each {|n|
        #  if board[n] == " " 
        #     return false
        #  end
        # }
        board.all? {|b| b != " "}
    end

    def draw?
       full? && !won?
    end

    def over?
       draw? || won?
    end

    def winner
        if n = won?
            board[n[0]]
        end
    end

    def play
        until over?
            turn
        end

        if won?
            puts "Congratulations #{self.winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end

