extends Node

var player_hand_scene = preload("res://scenes/player_hand.tscn")
const suits : Array[String] = ["spades","clubs","hearts","diamonds"]
var deck : Array[PlayingCardData] = []

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func generateDeck(deckCount: int):
	for i in range(deckCount):
		for suit in len(Global.Suit):
			for rank in range(1,14):
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
		
	
func dealFromDeck(playerHand):
	playerHand.display_card(deck.pop_back());

func start_game(deckCount: int):
	generateDeck(deckCount)
	shuffleDeck()
	$StartMenu.hide()
	var playerHand = player_hand_scene.instantiate()
	playerHand.connect("get_card_from_deck",dealFromDeck.bind(playerHand))
	add_child(playerHand)
