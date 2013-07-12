require 'pry'

class Card
  attr_accessor :card_type, :card_suit

  def initialize(type, suit)
    @card_type = type
    @card_suit = suit
  end

  def to_words
    "#{card_type} of #{card_suit}"
  end

  def to_s
    to_words
  end
end

class Deck  
  attr_accessor :cards

  def initialize
    @cards = []
    ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"].each do |type|
      ["Clubs", "Diamonds", "Spades", "Hearts"].each do |suit|
        @cards << Card.new(type, suit)
      end
    end
    shuffle_deck!
  end

  def shuffle_deck!
    cards.shuffle!
  end

  def deal_card
    cards.pop
  end
end

module PlayerDealerHand
  CARD_VALUES = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}

  def points
    temp = []
    hand.each do |card|
      temp << card.card_type.downcase.to_sym
    end
    temp.map { |e| CARD_VALUES[e] }
  end

  def total
    value = []
    value << points.select { |e| e != "ace" }.inject(0, :+)
    if points.include?("ace")    
      points.select { |e| e == "ace" }.count.times do
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

  def get_card(card)
    hand << card
  end

  def busted?
    total.select { |x| x < 22 } == []
  end

  def show_hand
    puts 
    puts "----#{name}'s current cards:----".center(44)
    hand.each { |card| puts card.to_s.center(44) }
    puts
    puts "----#{name}'s card value is: #{total}----".center(44)
    puts
  end
end

class Player
  include PlayerDealerHand

  attr_accessor :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end
end

class Dealer
  include PlayerDealerHand

  attr_accessor :name, :hand

  def initialize
    @name = "Dealer"
    @hand = []
  end

  def show_flop
    puts
    puts "----Dealer's visible card:----".center(44)
    puts hand[0].to_s.center(44)
    puts
  end
end

class Blackjack
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new("Player1")
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def player_name
    puts "Please enter your name"
    player.name = gets.chomp
  end

  def deal_cards
    2.times do
      player.hand << deck.deal_card
      dealer.hand << deck.deal_card
    end
    player.show_hand
    puts
    dealer.show_flop
    puts "-----Enter to Continue-----".center(44)
    gets
    puts
    puts
  end

  def player_turn
    while !player.busted?
      puts
      puts "Make a choice from the following options"
      puts "----------------------------------------"
      puts "1........Hit"
      puts "2........Review Hand"
      puts "3........Look at dealer's card"
      puts "4........Stay"
      puts
      choice = gets.chomp
      case choice
      when "1"
        player.hand << deck.deal_card
        player.show_hand
        puts "-----Enter to Continue-----".center(44)
        gets
        puts
        puts
      when "2"
        player.show_hand
        puts "-----Enter to Continue-----".center(44)
        gets
        puts
        puts
      when "3"
        dealer.show_flop
        puts "-----Enter to Continue-----".center(44)
        gets
        puts
        puts
      when "4"
        break
      else
        player_turn
      end
    end
    #blackjack_or_bust
    puts "#{player.name} stays."
  end

  def start
    player_name
    deal_cards
    player_turn
    #dealer_turn
    #end_game
    #new_game
  end
end

game = Blackjack.new
game.start