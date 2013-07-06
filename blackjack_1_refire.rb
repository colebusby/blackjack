#methods
def shuffle_deck
  card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  card_suits = ["Clubs", "Diamonds", "Spades", "Hearts"]
  @card_values = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
  @deck = card_types.product(card_suits).shuffle!
end

def deal
  2.times do
      @player_hand << @deck.pop.join(" of ")
      @player_points << @card_values[@player_hand.last.split[0].downcase.to_sym]
      @dealer_hand << @deck.pop.join(" of ")
      @dealer_points << @card_values[@dealer_hand.last.split[0].downcase.to_sym]
    end
    puts "You were dealt a #{@player_hand[0]} and a #{@player_hand[1]}."
    report_total(@player_points)
    end_game if blackjack?(@player_hand, @player_points)
    puts
    puts "The dealer's visible card is a #{@dealer_hand[0]}."
    puts
    end_game if blackjack?(@dealer_hand, @dealer_points)
end

def report_total(hand_points)
  puts "Your cards currently total: #{points(hand_points).join(" or ")}"
end

def hit(hand, hand_points)
  hand << @deck.pop.join(" of ")
  hand_points << @card_values[hand.last.split[0].downcase.to_sym]
  puts "The #{hand.last} was dealt."
  end_game if busted?(hand_points)
  report_total(hand_points) if hand_points != @dealer_points
  puts
  options(hand, hand_points) if hand != @dealer_hand
end

def stay
  until dealer_above_17?
    hit(@dealer_hand, @dealer_points)
  end
  end_game
end

def dealer_above_17?
  points(@dealer_points).each do |number|
    return true if number >= 17
  end
  false
end

def points(hand_points)
  value = []
  value << hand_points.select { |e| e != "ace" }.inject(0, :+)
  if hand_points.include?("ace")    
    hand_points.select { |e| e == "ace" }.count.times do
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

def busted?(hand_points)
  return true if points(hand_points).select { |x| x < 22 } == []
  false
end

def blackjack?(hand, hand_points)
  return true if points(hand_points).include?(21) && hand.count == 2
  false
end

def options(hand, hand_points)
  actions = ["1", "2"]
  puts "Enter a number to select your choice:"
  puts "1.....Hit (get another card)"
  puts "2.....Stay (keep your cards)"
  action = gets.chomp
  puts
  options(hand, hand_points) unless actions.include?(action)
  hit(hand, hand_points) if action == "1"
  stay if action == "2"
end

def begin_game
  @player_hand = []
  @player_points = []
  @dealer_hand = []
  @dealer_points = []

  puts "LET'S PLAY BLACKJACK!"
  puts
  puts "Please enter your name:"
  @name = gets.chomp
  puts
  shuffle_deck
  deal
  options(@player_hand, @player_points)
end

def final_points(hand_points)
  value = [0]
  points(hand_points).each do |number|
    value.replace([number]) if number > value[0] && number < 22
  end
  value[0]
end

def end_game
  if busted?(@player_points)
    puts
    puts "Oh no, you busted! Better luck next time."
    puts "House wins."
    puts
    begin_game
  elsif blackjack?(@player_hand, @player_points)
    puts
    puts "You hit Blackjack! What great luck you are having. You should definitely keep playing!"
    puts "You win."
    puts
    begin_game
  elsif busted?(@dealer_points)
    puts
    puts "House busted! The dealer looks sad for having lost."
    puts "The dealer's cards were: #{@dealer_hand.join(", ")}"
    puts "You win."
    puts
    begin_game
  elsif blackjack?(@dealer_hand, @dealer_points)
    puts
    puts "House hits Blackjack! The dealer gives you a smug look."
    puts "The dealer's cards were: #{@dealer_hand.join(", ")}"
    puts "House wins."
    puts
    begin_game
  elsif final_points(@player_points) > final_points(@dealer_points)
    puts
    puts "You win! With luck like this you got keep playing!"
    puts "The dealer scored #{final_points(@dealer_points)}, #{@name} scored #{final_points(@player_points)}"
    puts "The dealer's cards were: #{@dealer_hand.join(", ")}"
    puts
    begin_game
  elsif final_points(@player_points) < final_points(@dealer_points)
    puts
    puts "House wins! Don't worry, your luck will change. How about another game?"
    puts "The dealer scored #{final_points(@dealer_points)}, #{@name} scored #{final_points(@player_points)}"
    puts "The dealer's cards were: #{@dealer_hand.join(", ")}"
    puts
    begin_game
  elsif final_points(@player_points) == final_points(@dealer_points)
    puts
    puts "Draw! You can't let it end like this. Play another game!"
    puts "The dealer scored #{final_points(@dealer_points)}, #{@name} scored #{final_points(@player_points)}"
    puts "The dealer's cards were: #{@dealer_hand.join(", ")}"
    puts
    begin_game
  end
end

begin_game