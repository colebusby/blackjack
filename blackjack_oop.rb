class Blackjack  
  
  def initialize    
    player1 = Player.new
    player2 = Player.new
    player3 = Player.new
    player4 = Player.new
    @deck = Deck.new
    @players = [player1, player2, player3, player4]
  end

  class Deck

    attr_accessor :card_types, :card_suits, :deck

    def initialize
    @card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    @card_suits = ["Clubs", "Diamonds", "Spades", "Hearts"]    
    @deck = @card_types.product(@card_suits).shuffle!
    end

    def hit
    @deck.pop.join(" of ")
    end

  end


  class Player

    attr_accessor :name, :hand, :points, :card_values

    def initialize
    @name = "Place Holder"
    @hand = []
    @points = []
    @card_values = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
    end

  end

  def deal_cards
    @players.each do |player|
      @hand << @deck.hit
    end
  end

end