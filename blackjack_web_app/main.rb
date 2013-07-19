require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

set :sessions, true

helpers do
  CARD_VALUES = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:"jack", queen:"queen", king:"king"}

  def total(cards)
    arr = cards.map { |card| CARD_VALUES[card[0].downcase.to_sym] }
    value = []
    value << arr.select { |e| e.is_a?(Integer) }.inject(0, :+)
    arr.select { |e| e.is_a?(String) && e != "ace" }.size.times { value[0] += 10 }
    if arr.include?("ace")    
      arr.select { |e| e == "ace" }.count.times do
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

  def show_hand(dealer_or_player_hand)
    dealer_or_player_hand.each do |card|
      %Q(<img src="/images/cards/#{card[1].downcase}_#{CARD_VALUES[card[0].downcase.to_sym]}.jpg">)
    end
  end

  def busted?(dealer_or_player_hand)
    total(dealer_or_player_hand).select { |x| x < 22 } == []
  end

  def blackjack?(dealer_or_player_hand)
    total(dealer_or_player_hand).include?(21)
  end

  def dealer_17?
    total(session[:dealer_hand]).select { |x| x > 16 && x < 21 } != []
  end

  def final_total(dealer_or_player_hand)
    value = [0]
    total(dealer_or_player_hand).each do |number|
      value.replace([number]) if number > value[0] && number < 22
    end
    value[0]
  end

  def determine_winner
    if final_total(session[:player_hand]) > final_total(session[:dealer_hand])
      #player wins
      @success = "#{session[:player_name]} wins! #{session[:player_name]}'s total is: #{final_total(session[:player_hand])}  Dealer's total is: #{final_total(session[:dealer_hand])}"
      #would you like to play again
    elsif final_total(session[:player_hand]) == final_total(session[:dealer_hand])
      #player ties
      @error = "#{session[:player_name]} pushes. #{session[:player_name]}'s total is: #{final_total(session[:player_hand])}  Dealer's total is: #{final_total(session[:dealer_hand])}"
      #would you like to play again
    elsif final_total(session[:player_hand]) < final_total(session[:dealer_hand])
      #player loses
      @error = "#{session[:player_name]} loses! #{session[:player_name]}'s total is: #{final_total(session[:player_hand])}  Dealer's total is: #{final_total(session[:dealer_hand])}"
      #would you like to play again
    end
  end

end

before do
  @bust_or_stay = true
  @dealer_turn = false
  @game_over = false
end

get '/' do
  if session[:player_name]
    redirect '/game'
  else
    redirect 'new_player'
  end
end

get '/new_player' do
  erb :new_player
end

post '/new_player' do
  session[:player_name] = params[:player_name]
  redirect '/game'
end

get '/game' do
  #Dealing cards
  suits = ["Clubs", "Diamonds", "Spades", "Hearts"]
  values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  session[:deck] = values.product(suits).shuffle!
  session[:dealer_hand] = []
  session[:player_hand] = []
  2.times do
    session[:dealer_hand] << session[:deck].pop
    session[:player_hand] << session[:deck].pop
  end
  #session[:dealer_hand] = [["Ace", "Spades"], ["Five", "Clubs"]]

  #Special conditions after initial deal
  if blackjack?(session[:player_hand]) && blackjack?(session[:dealer_hand])
    @error = "Both you and the dealer were dealt a blackjack. The hand ends in a push."
    @bust_or_stay = false
    @game_over = true
    #push
    #would you like to play again?
  elsif blackjack?(session[:player_hand])
    @success = "You hit blackjack!"
    @bust_or_stay = false
    @game_over = true
    #player wins
    #would you like to play again?
  elsif blackjack?(session[:dealer_hand])
    @error = "Oh no, the dealer was dealt a blackjack! The best you can hope for is a push this hand."
  end

  erb :game
end

post '/game/player/hit' do
  session[:player_hand] << session[:deck].pop
  if busted?(session[:player_hand])
    @error = "Sorry, you busted. Better luck next time!"
    @bust_or_stay = false
    @game_over = true
    #player loses
    #would you like to play again?
  elsif blackjack?(session[:player_hand])
    @success = "You hit blackjack!"
    @bust_or_stay = false
    @game_over = true
    #player wins
    #would you like to play again      
  end
  erb :game
end

post '/game/player/stay' do
  @success = "You chose to stay."
  @bust_or_stay = false
  erb :game
end

post '/game/dealer/turn' do
  @dealer_turn = true
  @bust_or_stay = false
  if blackjack?(session[:dealer_hand]) || dealer_17?
    @game_over = true
    determine_winner
    #would you like to play again
  end

  erb :game
end

post '/game/dealer/hit' do
  @bust_or_stay = false
  @dealer_turn = true
  session[:dealer_hand] << session[:deck].pop
  if busted?(session[:dealer_hand])
    @success = "The dealer busted. You win!"
    @game_over = true
    #Player wins
    #would you like to play again
  elsif blackjack?(session[:dealer_hand]) || dealer_17?
    @game_over = true
    determine_winner
    #would you like to play again
  end
  erb :game
end

get '/game/new_round' do
  redirect '/new_player'

  erb :game
end