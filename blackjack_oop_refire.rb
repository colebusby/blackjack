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

  def blackjack?
    total.include?(21)
  end

  def show_hand
    puts 
    puts "----#{name}'s current cards:----".center(44)
    hand.each { |card| puts card.to_s.center(44) }
    puts
    puts "----#{name}'s card value is: #{total}----".center(44)
    puts
  end

  def final_total
    value = [0]
    total.each do |number|
      value.replace([number]) if number > value[0] && number < 22
    end
    value[0]
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

  def dealer_17?
    total.select { |x| x > 16 } != []
  end
end

class Blackjack
  attr_accessor :players, :dealer, :deck

  def initialize
    @players = []
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def player_names
    while true
      puts "Please type in a name followed by the 'Enter' key for each player."
      puts "When you are finished, hit 'Enter' one more time."
      answer = gets.chomp
      break if answer == ""
      players << answer
    end
    players.map! { |name| name = Player.new(name) }
  end

  def deal_cards
    2.times do
      players.each { |player| player.hand << deck.deal_card }
      dealer.hand << deck.deal_card
    end
  end

  def player_turn
    players.each do |player|
      player.show_hand
      dealer.show_flop
      puts "-----Enter to Continue-----".center(44)
      gets
      while !player.busted? && !player.blackjack?
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
        when "2"
          player.show_hand
          puts "-----Enter to Continue-----".center(44)
          gets
          puts
        when "3"
          dealer.show_flop
          puts "-----Enter to Continue-----".center(44)
          gets
          puts
        when "4"
          puts "#{player.name} stays."
          break
        else
          puts "Please choose from the available choices."
        end
      end
    end
  end

  def dealer_turn
    while !dealer.dealer_17? && !dealer.blackjack?
      dealer.hand << deck.deal_card
    end
  end

  def end_game
    #For players that busted.
    players.each do |player|
      if player.busted?
        puts "#{player.name} busted! #{player.name} loses."
      end
    end

    #For players that hit Blackjack.
    players.each do |player|
      if player.blackjack?
        puts "#{player.name} hit Blackjack! #{player.name} wins!"
      end
    end

    #For dealer bust.
    if dealer.busted?
      dealer.show_hand
      puts "The dealer busted! The house loses!"
      puts
      players.each do |player|
        if !player.busted? && !player.blackjack?
          puts "#{player.name} wins!"
        end
      end
      puts "-----Enter to Continue-----".center(44)
      gets
      new_game
    end

    #For dealer stay.
    dealer.show_hand
    puts
    puts "Dealer stays"
    players.each do |player|
      if !player.busted? && !player.blackjack?
        if player.final_total > dealer.final_total
          puts "#{player.name} wins!"
          puts "#{player.name}'s total is: #{player.final_total}  The dealer's total is: #{dealer.final_total}"
        end
        if player.final_total == dealer.final_total
          puts "#{player.name} pushed!"
          puts "#{player.name}'s total is: #{player.final_total}  The dealer's total is: #{dealer.final_total}"
        end
        if player.final_total < dealer.final_total
          puts "#{player.name} loses!"
          puts "#{player.name}'s total is: #{player.final_total}  The dealer's total is: #{dealer.final_total}"
        end
      end
    end
    new_game
  end

  def new_game
    puts
    puts "Would you like to play again?"
    puts "1......Yes"
    puts "2......No"
    answer = gets.chomp
    if answer == "1"
      deck = Deck.new
      dealer.hand = []
      players.each do |player|
        player.hand = []
      end
      start
    else
      exit
    end
  end

  def start
    player_names if players == []
    deal_cards
    player_turn
    dealer_turn
    end_game
    new_game
  end
end

game = Blackjack.new
game.start