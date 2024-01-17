class TicTacToe
    attr_reader :players, :board,:current_player
    def initialize
        @board=[nil, nil, nil, nil, nil, nil, nil, nil, nil]
        @players=[]
    end
    def start
        if players.length!=2
            raise StandardError "two players are required for this game"
        end
        @current_player=players.first
        while !(win || draw) do
        render
        askposition
        switchplyer
        end
    end

    def switchplyer
       @current_player=(current_player==players.first)? players.last : players.first 
    end
    def askposition
        puts "#{current_player.name} choose your spot between 1-9"
        location = gets.chomp.to_i
        board[location-1]=current_player.mark
    end

    def render
        puts "  #{board[0] || " "} | #{board[1] || " "} | #{board[2] || " "}"
        puts "-------------"
        puts "  #{board[3] || " "} | #{board[4] || " "} | #{board[5] || " "}"
        puts "-------------"
        puts "  #{board[6] || " "} | #{board[7] || " "} | #{board[8] || " "}"
    end

    def win
        false
    end

    def draw
        false
    end


    def add_players
        mark= players.empty?? "X":"O"
        puts "enter player name:"
        name=gets.chomp
        players<<Player.new(name,mark)
    end
end
class Player
    attr_reader :name, :mark
    def initialize(name, mark)
        @name=name
        @mark=mark
    end
end


game=TicTacToe.new
game.add_players
game.add_players
p game.players
game.start

