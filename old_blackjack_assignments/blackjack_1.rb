#class Blackjack

  #def initialize
    @dealer_options = ["Barabara", "Gerald", "Nancy", "Frank"]
    @card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    @card_suits = ["Clubs", "Diamonds", "Spades", "Hearts"]
    @card_values = {two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
    @deck = @card_types.product(@card_suits).shuffle!
    @name = ""
    @dealer = @dealer_options[rand(4)]
    @player_hand = []
    @dealer_hand = []
    @dealt_cards = []
    @player_value = [0]
    @dealer_value = [0]
  #end

  def deal_cards
    2.times do
      @player_hand << @deck.pop.join(" of ")
      @dealer_hand << @deck.pop.join(" of ")
    end
    puts "You were dealt a #{@player_hand[0]} and a #{@player_hand[1]}."
    puts
    puts "The dealer's visible card is a #{@dealer_hand[0]}."
  end

  def ace_check?(hand)
    hand.each do |string|
      return true if string.split[0] == "Ace"
    end
    false
  end

  def bust_check?(arr)
    return true if arr.select { |x| x < 21 } == []
    false
  end

 def ace_value(hand, one_or_eleven)
    value = 0
    hand.each do |string|
        if string.split[0] == "Ace"
          value += one_or_eleven
        else
          value += @card_values[string.split[0].downcase.to_sym]
        end
    end
    @value_arr << value
  end

  def hand_value(hand)
    value = 0
    @value_arr = []
    if ace_check?(hand) == false
      hand.each do |string|
        value += @card_values[string.split[0].downcase.to_sym]
      end
      @value_arr << value
    else
      ace_value(hand, 1)
      ace_value(hand, 11)    
    end
    @value_arr
  end

  def hit(hand)
    hand << @deck.pop.join(" of ")
    puts
    puts "#{hand.last}"
    puts
  end

  def review_player_hand
    puts
    puts "You currently have the following cards in your hand:"
    puts "#{@player_hand.join(", ")}"
    puts
    puts "Your hand value(s) is(are): #{hand_value(@player_hand).join(", ")}"
    puts
  end

  def dealer_card
    puts
    puts "The dealer's visible card is: #{@dealer_hand[0]}"
    puts
  end

  def dealer_above_17?
    hand_value(@dealer_hand).each do |number|
      return true if number >= 17
    end
    false
  end

  def player_final_score
    hand_value(@player_hand).each do |number|
      @player_value.replace([number]) if number > @player_value[0] && number < 22
    end
    @player_value[0]
  end

  def dealer_final_score
    hand_value(@dealer_hand).each do |number|
      @dealer_value.replace([number]) if number > @dealer_value[0] && number < 22
    end
    @dealer_value[0]
  end

  def hold
    until dealer_above_17?
      hit(@dealer_hand)
    end
    if bust_check?(hand_value(@dealer_hand))
      puts
      puts "Dealer busts, you win!!!"
      puts "The dealers cards were: #{@dealer_hand.join(", ")}"
      puts
      puts "#{@dealer} looks sad for having lost."
      puts
      exit
    else
      if dealer_final_score > player_final_score
        puts
        puts "The house wins!"
        puts "#{@dealer} scored #{dealer_final_score}, #{@name} scored #{player_final_score}"
        puts "The dealers cards were: #{@dealer_hand.join(", ")}"
        puts
        exit
      else
        puts
        puts "You win!"
        puts "#{@dealer} scored #{dealer_final_score}, #{@name} scored #{player_final_score}"
        puts "The dealers cards were: #{@dealer_hand.join(", ")}"
        puts
        exit
      end
    end
  end

  def options
    puts "Please enter the number for the action you would like to complete:"
    puts
    puts "1.....Hit (get another card)"
    puts "2.....Review Hand (look at your cards and your hand value)"
    puts "3.....Dealer Card (look at the dealer's visible card)"
    puts "4.....Stay (Keep your cards and see how they stack up against the dealer)"
    @action = gets.chomp
  end

  method_check = ["1", "2", "3", "4"]

  def method_dispatch
    hit(@player_hand) if @action == "1"
    if bust_check?(hand_value(@player_hand))
      puts "Oh no, you bust! Dealer wins."
      puts
      exit
    end
    review_player_hand if @action == "2"
    dealer_card if @action == "3"
    hold if @action == "4"
  end

#end

#game = Blackjack.new
puts "Let's play Blackjack!"
puts "What is your name?"
@name = gets.chomp
puts
puts "Your dealer today is #{@dealer}."
puts
puts"Let's get started!"
puts
deal_cards
puts
while true
  options
  if method_check.include?(@action)
    method_dispatch
  else
    puts
    puts "Please choose a valid option"
    puts
  end
end