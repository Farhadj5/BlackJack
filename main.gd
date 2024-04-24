extends Node

const suits : Array[String] = ["spades","clubs","hearts","diamonds"]
var deck : Array[PlayingCardData] = []
@export var deckCount : int = 1

func _ready():
	generateDeck(deckCount)
	shuffleDeck()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func generateDeck(deckCount: int):
	for i in range(deckCount):
		for suit in suits:
			for rank in range(14):
				deck.append(PlayingCardData.new(suit,rank))
				
func shuffleDeck():
	var rng = RandomNumberGenerator.new()

	for i in range(len(deck)-1,0,-1):
		# Pick a random index from 0 to i
		var j = rng.randf_range(0, i+1)
		# Swap arr[i] with the element at random index
		var tmp = deck[i]
		deck[i] = deck[j]
		deck[j] = tmp
		
	
