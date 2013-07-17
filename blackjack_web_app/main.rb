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

  def busted?(dealer_or_player_hand)
    total(dealer_or_player_hand).select { |x| x < 22 } == []
  end

  def blackjack?(dealer_or_player_hand)
    total(dealer_or_player_hand).include?(21)
  end

end

before do
  @bust_or_stay = true  
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
  suits = ["Clubs", "Diamonds", "Spades", "Hearts"]
  values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  session[:deck] = values.product(suits).shuffle!
  session[:dealer_hand] = []
  session[:player_hand] = []
  2.times do
    session[:dealer_hand] << session[:deck].pop
    session[:player_hand] << session[:deck].pop
  end
  if blackjack?(session[:player_hand]) && blackjack?(session[:dealer_hand])
    @error = "Both you and the dealer were dealt a blackjack. The hand ends in a push."
    @bust_or_stay = false
    #push
    #would you like to play again?
  elsif blackjack?(session[:player_hand])
    @success = "You hit blackjack!"
    @bust_or_stay = false
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
    #player loses
    #would you like to play again?
  elsif blackjack?(session[:player_hand])
    @success = "You hit blackjack!"
    @bust_or_stay = false
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