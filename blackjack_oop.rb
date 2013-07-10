class Blackjack

#Initialize
  CARD_VALUES = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
  attr_accessor :game_deck, :player1, :dealer
  @@game_deck = []

  def initialize
    @@game_deck = Deck.new
    @player1 = Player.new
    @dealer = Dealer.new
  end

#Modules

  module BlackjackHelp

    def hit
      @hand << Blackjack.game_deck.deal
      @points << CARD_VALUES[@hand.last.split[0].downcase.to_sym]
    end

    def total
      value = []
      value << @points.select { |e| e != "ace" }.inject(0, :+)
      if @points.include?("ace")    
        @points.select { |e| e == "ace" }.count.times do
          value2 = value
          temp = []
          value2.each do |number|
            temp << number + 1
            temp << number + 11
          end
          value = temp
        end
      end
      value.uniq
    end
  
    def conditions_check
      #busted
      puts "end_game" if total.select { |x| x < 22 } == []
      #blackjack
      puts "end_game" if total.include?(21) && @hand.count == 2
      #21 after hitting
      puts "stay" if total.include?(21) && @hand.count > 2
    end
  end

#Subclasses

  class Deck
    attr_accessor :deck
    def initialize
      card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
      card_suits = ["Clubs", "Diamonds", "Spades", "Hearts"]
      @deck = card_types.product(card_suits).shuffle!
    end

    def deal
      @deck.pop.join(" of ")
    end
  end

  class Player
    include BlackjackHelp
    attr_accessor :hand, :points
    def initialize
      @hand = []
      @points = []
    end

    def options
      actions = ["1", "2"]
      puts "Enter a number to select your choice:"
      puts "1.....Hit (get another card)"
      puts "2.....Stay (keep your cards)"
      action = gets.chomp
      puts
      options unless actions.include?(action)
      if action == "1"
        hit
        puts "You were dealt a #{@hand.last}"
        puts "Your current total is: #{total}"
        conditions_check
        options
      end
    end
  end

  class Dealer
    include BlackjackHelp
    attr_accessor :name, :hand, :points
    def initialize
      names_arr = ["Harold", "Barbara", "Ted", "Fiona"]
      @name = names_arr[rand(4)]
      @hand = []
      @points = []
    end

    def dealer_above_17?
      total(@points).each do |number|
        return true if number >= 17
      end
      false
    end
  end

#Methods

  def new_deck
    @@game_deck = Deck.new
  end

  def self.game_deck
    @@game_deck
  end

  def start
    puts
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "$                             $"
    puts "$   Welcome to Blackjack!!!   $"
    puts "$                             $"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts
    puts "Hello, my name is #{self.dealer.name}. I will be your dealer today."
    puts "Let's get started!"
    puts
    2.times do
      self.player1.hit
      self.dealer.hit
    end
    puts "#{self.dealer.name} deals you a #{self.player1.hand[0]}, and a #{self.player1.hand[1]}"
    puts "Your current points total is: #{self.player1.total}"
    puts
    puts "The dealer's visible card is a #{self.dealer.hand[0]}"
    puts
    self.player1.conditions_check
    self.dealer.conditions_check
    self.player1.options
  end
end

game = Blackjack.new
game.start