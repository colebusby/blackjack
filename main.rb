require 'rubygems'
require 'sinatra'
#require 'sinatra/reloader'

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
    arr = []
    dealer_or_player_hand.each do |card|
      arr << %Q(<img src="/images/cards/#{card[1].downcase}_#{CARD_VALUES[card[0].downcase.to_sym]}.jpg" class="img-polaroid">)
    end
    arr.join("  ")
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
    if session[:split_bet] > 0
      if !busted?(session[:player_hand]) && final_total(session[:player_hand]) > final_total(session[:dealer_hand]) && final_total(session[:player_split]) > final_total(session[:dealer_hand])
        session[:player_balance] += session[:player_bet_total]
        @winner = "#{session[:player_name]} wins! #{session[:player_name]}'s split earned: $#{session[:split_bet]}    #{session[:player_name]}'s other hand earned: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif !busted?(session[:player_hand]) && final_total(session[:player_hand]) < final_total(session[:dealer_hand]) && final_total(session[:player_split]) > final_total(session[:dealer_hand])
        session[:player_balance] += session[:split_bet]
        session[:player_balance] -= session[:player_bet]
        @loser = "#{session[:player_name]}'s split earned: $#{session[:split_bet]}    #{session[:player_name]}'s other hand lost: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif !busted?(session[:player_hand]) && final_total(session[:player_hand]) > final_total(session[:dealer_hand]) && final_total(session[:player_split]) < final_total(session[:dealer_hand])
        session[:player_balance] += session[:player_bet]
        session[:player_balance] -= session[:split_bet]
        @loser = "#{session[:player_name]}'s split lost: $#{session[:split_bet]}    #{session[:player_name]}'s other hand earned: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif !busted?(session[:player_hand]) && final_total(session[:player_hand]) == final_total(session[:dealer_hand]) && final_total(session[:player_split]) > final_total(session[:dealer_hand])
        session[:player_balance] += session[:split_bet]
        @winner = "#{session[:player_name]} wins! #{session[:player_name]}'s split earned: $#{session[:split_bet]}    #{session[:player_name]}'s other hand pushed.    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif !busted?(session[:player_hand]) && final_total(session[:player_hand]) > final_total(session[:dealer_hand]) && final_total(session[:player_split]) == final_total(session[:dealer_hand])
        session[:player_balance] += session[:player_bet]
        @winner = "#{session[:player_name]} wins! #{session[:player_name]}'s split pushed.    #{session[:player_name]}'s other hand earned: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif !busted?(session[:player_hand]) && final_total(session[:player_hand]) < final_total(session[:dealer_hand]) && final_total(session[:player_split]) < final_total(session[:dealer_hand])
        session[:player_balance] -= session[:player_bet_total]
        @loser = "#{session[:player_name]} loses! #{session[:player_name]}'s split lost: $#{session[:split_bet]}    #{session[:player_name]}'s other hand lost: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif busted?(session[:player_hand]) && final_total(session[:player_split]) > final_total(session[:dealer_hand])
        session[:player_balance] += session[:split_bet]
        session[:player_balance] -= session[:player_bet]
        @loser = "#{session[:player_name]}'s split earned: $#{session[:split_bet]}    #{session[:player_name]}'s other hand lost: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif busted?(session[:player_hand]) && final_total(session[:player_split]) < final_total(session[:dealer_hand])
        session[:player_balance] -= session[:player_bet_total]
        @loser = "#{session[:player_name]} loses! #{session[:player_name]}'s split lost: $#{session[:split_bet]}    #{session[:player_name]}'s other hand lost: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif busted?(session[:player_hand]) && final_total(session[:player_split]) == final_total(session[:dealer_hand])
        session[:player_balance] -= session[:player_bet]
        @loser = "#{session[:player_name]}'s split pushed.    #{session[:player_name]}'s other hand lost: $#{session[:player_bet]}    #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      end
    else
      if final_total(session[:player_hand]) > final_total(session[:dealer_hand])
        session[:player_balance] += session[:player_bet]
        @winner = "#{session[:player_name]} wins! #{session[:player_name]}'s total is: #{final_total(session[:player_hand])}  Dealer's total is: #{final_total(session[:dealer_hand])} #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      elsif final_total(session[:player_hand]) == final_total(session[:dealer_hand])
        @loser = "#{session[:player_name]} pushes. #{session[:player_name]}'s total is: #{final_total(session[:player_hand])}  Dealer's total is: #{final_total(session[:dealer_hand])} #{session[:player_name]}'s balance remains at: $#{session[:player_balance]}"
      elsif final_total(session[:player_hand]) < final_total(session[:dealer_hand])
        session[:player_balance] -= session[:player_bet]
        @loser = "#{session[:player_name]} loses! #{session[:player_name]}'s total is: #{final_total(session[:player_hand])}  Dealer's total is: #{final_total(session[:dealer_hand])} #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      end
    end
  end

end

before do
  @bust_or_stay = true
  @dealer_turn = false
  @game_over = false
  @split = false
  @split_turn = false
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
  if params[:player_name].empty?
    @error = "Name is required!"
    halt erb :new_player
  end
  session[:player_name] = params[:player_name]
  session[:player_balance] = 500
  redirect '/player_bet'
end

get '/player_bet' do
  if session[:player_balance] == 0
    redirect '/game_over'
  end
  erb :player_bet
end

post '/player_bet' do
  if params[:player_bet].empty? || params[:player_bet].to_i <= 0
    @error = "You must make a bet!"
    halt erb :player_bet
  elsif session[:player_balance] < params[:player_bet].to_i
    @error = "The house does not play on credit! Do not try to bet more than you have!"
    halt erb :player_bet
  end
  session[:player_bet] = params[:player_bet].to_i
  session[:split_bet] = 0
  session[:player_bet_total] = session[:player_bet] + session[:split_bet]
  redirect '/game'
end

get '/game' do
  #Dealing cards
  suits = ["Clubs", "Diamonds", "Spades", "Hearts"]
  values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
  session[:deck] = values.product(suits).shuffle!
  session[:dealer_hand] = []
  session[:player_hand] = []
  session[:player_split] = []
  2.times do
    session[:dealer_hand] << session[:deck].pop
    session[:player_hand] << session[:deck].pop
  end

  #Special conditions after initial deal
  if blackjack?(session[:player_hand]) && blackjack?(session[:dealer_hand])
    @error = "Both #{session[:player_name]} and the dealer were dealt a blackjack. The hand ends in a push. #{session[:player_name]}'s balance remains at: $#{session[:player_balance]}"
    @bust_or_stay = false
    @game_over = true
  elsif blackjack?(session[:player_hand])
    session[:player_balance] += (session[:player_bet] * 1.5).to_i
    @success = "#{session[:player_name]} hit blackjack! #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
    @bust_or_stay = false
    @game_over = true
  elsif blackjack?(session[:dealer_hand])
    @error = "Oh no, the dealer was dealt a blackjack! The best #{session[:player_name]} can hope for is a push this hand."
  end

  erb :game
end

post '/game/player/hit' do
  session[:player_hand] << session[:deck].pop
  if busted?(session[:player_hand])
    if session[:split_bet] > 0
      @loser = "#{session[:player_name]} busted."
      @bust_or_stay = false
    else
      session[:player_balance] -= session[:player_bet]
      @loser = "#{session[:player_name]} busts! Better luck next time. #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      @game_over = true
    end
    @bust_or_stay = false
  elsif blackjack?(session[:player_hand])
    @winner = "#{session[:player_name]} hit blackjack!"
    @bust_or_stay = false    
  end
  erb :game, layout: false
end

post '/game/split/hit' do
  @bust_or_stay = false
  @split = true
  @split_turn = true
  session[:player_split] << session[:deck].pop
  if busted?(session[:player_split])
    session[:player_balance] -= session[:split_bet]
    session[:player_bet_total] -= session[:split_bet]
    session[:split_bet] = 0
    @loser = "Sorry, #{session[:player_name]} busted. Better luck next time! #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
    @split_turn = false
    @bust_or_stay = true
  elsif blackjack?(session[:player_split])
    @winner = "#{session[:player_name]} hit blackjack!"
    @split_turn = false
    @bust_or_stay = true
  end
  erb :game, layout: false
end

post '/game/player/double_down' do
  session[:player_hand] << session[:deck].pop
  session[:player_bet_total] += session[:player_bet]
  session[:player_bet] *= 2
  @bust_or_stay = false
  if busted?(session[:player_hand])
    if session[:split_bet] > 0
      @loser = "#{session[:player_name]} busted."
    else
      session[:player_balance] -= session[:player_bet_total]
      @loser = "#{session[:player_name]} busts! Better luck next time. #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
      @game_over = true
    end
    @bust_or_stay = false
  elsif blackjack?(session[:player_hand])
    @winner = "#{session[:player_name]} hit blackjack! #{session[:player_name]}'s new bet is: $#{session[:player_bet]}"
  else
    @winner = "#{session[:player_name]} doubled down. #{session[:player_name]}'s new bet is: $#{session[:player_bet]}"
  end
  erb :game, layout: false
end

post '/game/split/double_down' do
  @split = true
  @split_turn = true
  session[:player_split] << session[:deck].pop
  session[:split_bet] *= 2
  session[:player_bet_total] = session[player_bet] + session[:split_bet]
  if busted?(session[:split_hand])
    session[:player_balance] -= session[:split_bet]
    session[:player_bet_total] -= session[:split_bet]
    session[:split_bet] = 0
    @loser = "Sorry, #{session[:player_name]} busted. Better luck next time! #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
    @split_turn = false
  elsif blackjack?(session[:player_hand])
    @winner = "#{session[:player_name]} hit blackjack!"
    @split_turn = false
  else
    @winner = "#{session[:player_name]} doubled down. #{session[:player_name]}'s new bet is: $#{session[:split_bet]}"
    @split_turn = false
  end
  erb :game, layout: false
end

post '/game/player/split' do
  @split = true
  @split_turn = true
  session[:split_bet] = session[:player_bet]
  session[:player_split] << session[:player_hand].pop
  session[:player_split] << session[:deck].pop
  session[:player_hand] << session[:deck].pop
  erb :game, layout: false
end

post '/game/player/stay' do
  @winner = "#{session[:player_name]} chose to stay."
  @bust_or_stay = false
  erb :game, layout: false
end

post '/game/split/stay' do
  @winner = "#{session[:player_name]} chose to stay the split."
  erb :game, layout: false
end

post '/game/split/end' do
  erb :game
end

post '/game/dealer/turn' do
  @dealer_turn = true
  @bust_or_stay = false
  if blackjack?(session[:dealer_hand]) || dealer_17?
    @game_over = true
    determine_winner
  end

  erb :game
end

post '/game/dealer/hit' do
  @bust_or_stay = false
  @dealer_turn = true
  session[:dealer_hand] << session[:deck].pop
  if busted?(session[:dealer_hand])
    session[:player_balance] += session[:player_bet]
    @winner = "The dealer busted. #{session[:player_name]} wins! #{session[:player_name]}'s new balance is: $#{session[:player_balance]}"
    @game_over = true
  elsif blackjack?(session[:dealer_hand]) || dealer_17?
    @game_over = true
    determine_winner
  end
  erb :game, layout: false
end

get '/game/new_round' do
  redirect '/player_bet'
end

get '/game_over' do
  @error = "You ran out of money!"
  erb :game_over
end

get '/game/new_game' do
  redirect '/new_player'
end