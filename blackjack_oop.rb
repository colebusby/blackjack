require 'pry'

class Blackjack

#Initialize
  CARD_VALUES = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
  attr_accessor :game_deck, :player1, :dealer
  @@game_deck = []

  def initialize(name)
    @@game_deck = Deck.new
    @player1 = Player.new(name)
    @dealer = Dealer.new
  end

#Modules

  module BlackjackHelp
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

  class Player < Blackjack
    attr_accessor :name, :hand, :points, :turn_over
    def initialize(name)
      @name = name
      @hand = []
      @points = []
      @turn_over = false
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
        puts
      end
      @turn_over = true if action == "2"
    end

    def hit
      @hand << Blackjack.game_deck.deal
      @points << CARD_VALUES[@hand.last.split[0].downcase.to_sym]
    end
  end

  class Dealer < Blackjack
    attr_accessor :name, :hand, :points, :turn_over
    def initialize
      names_arr = ["Harold", "Barbara", "Ted", "Fiona"]
      @name = names_arr[rand(4)]
      @hand = []
      @points = []
      @turn_over = false
    end

    def dealer_above_17?
      total.each do |number|
        @turn_over = true if number >= 17
      end
    end

    def hit
      @hand << Blackjack.game_deck.deal
      @points << CARD_VALUES[@hand.last.split[0].downcase.to_sym]
    end
  end

#Methods

  def conditions_check?
    #busted
    @turn_over = true if total.select { |x| x < 22 } == []
    #blackjack
    @turn_over = true if total.include?(21) && @hand.count == 2
    #21 after hitting
    @turn_over = true if total.include?(21) && @hand.count > 2
  end

  def busted?
    return true if total.select { |x| x < 22 } == []
    false
  end

  def blackjack?
    return true if total.include?(21) && @hand.count == 2
    false
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

  def new_deck
    @@game_deck = Deck.new
  end

  def self.game_deck
    @@game_deck
  end

  def final_points
    value = [0]
    total.each do |number|
      value.replace([number]) if number > value[0] && number < 22
    end
    value[0]
  end

  def end_game
    if self.player1.busted?
      puts
      puts "Oh no, you busted! Better luck next time."
      puts "House wins."
      puts
      return
    elsif self.player1.blackjack?
      puts
      puts "You hit Blackjack! What great luck you are having. You should definitely keep playing!"
      puts "You win."
      puts
      return
    elsif self.dealer.busted?
      puts
      puts "House busted! The dealer looks sad for having lost."
      puts "The dealer's cards were: #{self.dealer.hand.join(", ")}"
      puts "You win."
      puts
      return
    elsif self.dealer.blackjack?
      puts
      puts "House hits Blackjack! The dealer gives you a smug look."
      puts "The dealer's cards were: #{self.dealer.hand.join(", ")}"
      puts "House wins."
      puts
      return
    elsif self.player1.final_points > self.dealer.final_points
      puts
      puts "You win! With luck like this you got to keep playing!"
      puts "The dealer scored #{self.dealer.final_points}, You scored #{self.player1.final_points}"
      puts "The dealer's cards were: #{self.dealer.hand.join(", ")}"
      puts
      return
    elsif self.player1.final_points < self.dealer.final_points
      puts
      puts "House wins! Don't worry, your luck will change. How about another game?"
      puts "The dealer scored #{self.dealer.final_points}, You scored #{self.player1.final_points}"
      puts "The dealer's cards were: #{self.dealer.hand.join(", ")}"
      puts
      return
    elsif self.player1.final_points == self.dealer.final_points
      puts
      puts "Draw! You can't let it end like this. Play another game!"
      puts "The dealer scored #{self.dealer.final_points}, You scored #{self.player1.final_points}"
      puts "The dealer's cards were: #{self.dealer.hand.join(", ")}"
      puts
      return
    end
  end

  def new_game_initialize
    self.player1.hand = []
    self.player1.points = []
    self.player1.turn_over = false
    self.dealer.hand = []
    self.dealer.points = []
    self.dealer.turn_over = false
    @@game_deck = Deck.new
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
  #Player Turns
    self.player1.conditions_check?
    until self.player1.turn_over == true
      self.player1.options
      self.player1.conditions_check?
    end
  #Dealer Turn
    self.dealer.conditions_check?
    self.dealer.dealer_above_17?
    until self.dealer.turn_over == true
      self.dealer.hit
      self.dealer.conditions_check?
      self.dealer.dealer_above_17?
    end
  #End Game
    self.end_game
    self.new_game_initialize
    self.start
  end
end

puts "What is your name?"
answer = gets.chomp
game = Blackjack.new(answer)
game.start