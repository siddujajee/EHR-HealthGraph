class Fun
    attr_reader :blocks, :players, :current_player
    def initialize
        @blocks=[nil, nil, nil, nil, nil, nil, nil, nil, nil]
        @players=[]
    end
    def add_players
        symbol=players.empty? ? "X" : "0"
        puts "enter player's name"
        name=gets.chomp
        players<<Player.new(name, symbol)
    end

    def start
        if players.length!=2
            puts "requires 2 players for this game"
        end
        @current_player=players.first
        while !(win || draw) do
            render
            askposition
            switchplayers
        end
        if (winner = win)
            puts "#{winner.name} won"
            render
        else
            puts "it's a tie"
            render
        end
    end

    def switchplayers
        @current_player=(current_player==players.first)? players.last : players.first
    end

    def askposition
        puts "#{current_player.name} enter your position between 1 to 9"
        position=gets.chomp.to_i
        if(1..9).include?(position)
            if blocks[position-1]==nil
                blocks[position-1]=current_player
            else
                puts "the spot has already been taken"
                askposition
            end
        else
            puts "enter the number between 1 to 9 only"
            askposition
        end
    end

    def render
        puts "#{blocks[0]&.symbol || " "}  | #{blocks[1]&.symbol || " "} | #{blocks[2]&.symbol || " "}"
        puts "-----------"
        puts "#{blocks[3]&.symbol || " "}  | #{blocks[4]&.symbol || " "} | #{blocks[5]&.symbol || " "}"
        puts "-----------"
        puts "#{blocks[6]&.symbol || " "}  | #{blocks[7]&.symbol || " "} | #{blocks[8]&.symbol || " "}"
    end

    def win
        row=[blocks[0], blocks[1], blocks[2]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        row=[blocks[3], blocks[4], blocks[5]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        row=[blocks[6], blocks[7], blocks[8]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        row=[blocks[0], blocks[3], blocks[6]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        row=[blocks[1], blocks[4], blocks[7]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        row=[blocks[2], blocks[5], blocks[8]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        row=[blocks[0], blocks[4], blocks[8]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        row=[blocks[2], blocks[4], blocks[6]].compact
        return row.first if row.length==3 && row.all?{|r| r==row.first}
        
    end
    def draw
        blocks.none?(nil) && !win
    end
end


class Player
attr_reader :name, :symbol
    def initialize(name, symbol)
        @name=name
        @symbol=symbol
    end
end

f=Fun.new
f.add_players
f.add_players
f.start
