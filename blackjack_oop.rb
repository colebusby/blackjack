<<<<<<<<< saved version
class Blackjac
  
  attr
  
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

game = Blackjack.new

=========
<<<<<<<<< saved version
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

game = Blackjack.new

=========
<<<<<<<<< saved version
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

game = Blackjack.new

=========
<<<<<<<<< saved version
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
	  
	  de	f end
		
	end
	
	def deal_cards
		@players.each do |player|
			@hand << @deck.hit
		end
	end
	
end

game = Blackjack.new

=========
<<<<<<<<< saved version
class Blackjack
 
 
		player1 = Player.new
		player2 = Player.new
		player3 = Player.new
		player4 = Player.newdeck = Deck.new
    @players = [itiali, player2, player3, player4]
	end

	class Deck
	  
	  attr_accessor :card_types, :card_suits, :deck
			  
	  def initialize
		@card_["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
		@card_suits = ["Clubs", "Diamonds", "Spades", "Hearts"]    
		@deck = @card_types.product(@card_suits).shuffle!
	  end
	  
	  def hit
		@deck.pop.join(" of ")
	  end
	  
	end
	
	
	
	  
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
g

=========
<<<<<<<<< saved version
class Blackjack
  
	def initializeame s = [player1, player=, player3, player4]
		player1 Blackjackcl
		player2 = Player.new
		player3 = Player.new
		player4 = Player.newsdeck = Deck.new
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

game = Blackjack.new

=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@players = [player1, player2, player3, player4]
		player1 = Player.
		player4 = Player.new
		@deck = Deck.new
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

game = blackjack.new

=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@players = [player1, player2, player3, player4]
		player1 = Player.new
		player2 = Player.new
		player3 = Player.new
		player4 = Player.new
		@deck = Deck.new
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
		@card_values = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nins.each do |player|
			@hand << @deck.hit
		end
	end
	
end

game = blackjack.

=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@players = [player1, player2, pl]
		player1ayer3, playe
		player2 = Player.new
		player3 = Player.new
		player4 = Player.newe:9, ten:10, jac
	end

	class Deck
	  
	  attr_accessor :card_types, :card_suits, :deck
			  
	  def initialize
		@card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
		@card_suits = ["Clubs", "Diamonds", "Spades", "Hear		@deckt=s@card_types.product(@card_suits).shuffle!
	"end
	  
	  def hit
deck.	op.join(" of ")
	  end
	  
	end
	
	
	class 
	  
		attr_acceor :name, :hand, :points, :card_values
	  
	  def initialize
		@name = "Place Holder"
		@hand]
		@points = []
		@card_values = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
	  end
		
	end
	
	def deal_cards
	s.each do |player|
			@hand << @deck.hit
		end
	end
	
end

game = black

=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@playerplayer2, player3, player4]
		player1 = Player.new
		player2 = Player.new
		player3 = Player.new
		player4 = Player.newdeck = Deck.new
	end

	class Deck
	  
	  attr_accessor :cares, :card_suits, :deck
			  
	  def initiize
		@crd_tapds = ["Ace", "Two", "Th_ee", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
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
		@card_values =three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
	  end
		
	end
	
	def deal_cards
		 s.each do |player|
			@hand << @deck.hit
		end
	end
	
end

game = 

=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@players = [player1, playplayer4]
		player1 = Player.new
		player2 = Player.new
		player3 = Player.new
		player4 = Player.newdeck = Deck.new
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

game

=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
	@p	playlr1 = Player.aew
		player2 = Player.new
		player3 = Player.new
		player4 = Player.new
eck = Deck.new		end
yers = [plaer1,player2, player3, 
		er2, player{ace:"ace", two:y
		s= [player	sP	]    10, queen:10, king:10}
	  end
		
	end
	
	def deal_cardsew
		player2 = Player.new
		s typesze
		@name = "Place Holer"
		@hand = []
		@points = []
		@card_values = {ace:"ace" two:2, three:3, four:4, five:5, six:6, seven:7, eigt:8, nie:9,ten:10, jac:10, queen:10, king:10}
 
	definitalize			@layer1 = Playe.new
		@player2 = Player.new
		@player3 = Player.new
	@plyer4 = Player.new		@deck = Deck.new
    @payers = [@plaer1, @player2, player3, @player4]
	end

	class Deck
	  
	  attr_accessor :card_types, :card_suits, :deck
			  
	  def initialize
		@card_
	  end
		
	end
	
	def deal_cards
		@players.each do |player|
			@hand << @deck.hit
		end
	end
	
end



=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@players = [player1, player2,	player1 =pPlaylr.aew
		player2 = Player.new
		player3 = Player.new
		player4 = Player.new
eck = Deck.new	@end
yclass Decke	r3
	  attr_accessor :card_types, :card_suits, :deck
			  
	, pinitialize
		@card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
		@card_suits = ["Clubs", "Diamonds", "Spades", "Hearts"]    
		@deck = @card_types.product(@card_suits).shuffle!
	  end
	  
	  def hit
		@deck.pop.join(" of ")
	  end
	  
	end
	
	
	class Player
	  
		attr, :hand, :points, :card_values
	  
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


=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@players = [player1, player2, player3, player4]
		player1 = Player.new
		player2 = Player.new
		player3 = Player.new
		player4 = Player.new
		@deck = Deck.new
	end

	class Deck
	  
	  attr_accessor :card_types, :card_suits, :deck
			  
	  def initialize
		@card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "N		@card_suitsi=n["Clubs",e"Diamonds",""Spades",,"Hearts"]    
		@deck = @card_tyes.prod"cT(@card_euits).shuffle!
	 end
	  
	  def hit
deck.pop.join(" of ")
	  end
	  
	end
	
	
	class Player
	  
		attr_access, :hand, :points, :card_valuesr	 :
		d	f initialize
		@name = "Place Holer",		@hand ="[]
		@points=J[]ck	@card_values = {ace:"ace", two:2, three:3, four:4, five:5, six:6, seven:7, eight:8, nine:9, ten:10, jack:10, queen:10, king:10}
	  ",
		
	endQueen", "King"]acessor :layer4]ypes = ["Ace" "Two", "Three", "Four, "Fiv
	end"
, 

=========
<<<<<<<<< saved version
class Blackjack
  
	def initialize
		@players = [player1, player2, player3, player4]
		player1 = Player.new
		player2 = Pla	player3 = Player.newe		playrr4 = Player..ew
		@eck = Deck.new
	end

	class De	  k	  attr_accessor :card_types, :card_suits, :deck
			  
	  def initialize
		@card_types = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "ht", "Nine", "Ten", "Jack", "Queen", "King"]
		@card_suits = ["Clubs", "DiEonds", "Spadis", "Hearts"]    
		@deckew@card_types.product(@card_suits).shuffle!
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
	


  

	def initialize

		@players = [player1, player2, player3, player4]

		player1 = Pl

		player2 = Player.new

		player3 = Player.new

		player4 = Playe
		@deck = Deck.new

	end



	class Deck

	  

	  attr_accessor :card_types, :card_suits, :deck

			  

	  def initialize

		@card_types = ["Ace", "Two", "Three", "Four", "Five", "Siht", "Nine", "Ten", "Jack", "Queen", "King"]

		@card_suits = ["Clubs", "Dionds", "Spadxs", "Hearts"]    

		@deck = @card_typeprosuct(@card_suits).shuffl"!

	  end

	  

	  def hit

		@deck.pop.join(" of ")

	  end

	  

	ess Pnayer

	  

		aaccessor :name, :hand, :points, :ttrd_value

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
>>>>>>>>> local version
>>>>>>>>> local version
>>
>>>>>>>>> local version>>>>>>> local version
>>>>>>>>> local version>>>>>>> local version
>>
>>>>>>>>> local version
>>>>>>>>> local version
>>
>>>>>>>>> local version>>>>>>> local version
>>>>>>>>> local version>>>>>>> local version
>>
>>>>>>>>> local version
>>>>>>>>> local version
>>>>>>>>> local version
	

	

	cl, "Seven", "Eir.newyerend
=========
class Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
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
		
    def name
      puts @name
    end
    
	end
	
	def deal_cards
		@players.each do |player|
			@hand << @deck.hit
		end
	end
	
end

game = Blackjack.new
game.deal_cards

