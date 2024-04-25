extends Node

@export var deckCount = 1
var player_hand_scene = preload("res://scenes/player_hand.tscn")
var dealer_hand_scene = preload("res://scenes/dealer_hand.tscn")
var dealerHand = null
var playerHands = []
const suits : Array[String] = ["spades","clubs","hearts","diamonds"]
var deck : Array[PlayingCardData] = []

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func generateDeck(deckCount: int):
	deck = []
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
		
	
func dealCard(personHand: Node, isVisible: bool=true) -> bool:
	if (len(deck) == 0):
		generateDeck(deckCount)
		shuffleDeck()
	return personHand.dealCard(deck.pop_back(),isVisible);

func start_game(deckCount: int):
	for hand in playerHands:
		hand.queue_free()
	
	#Am I not freeing memory? If I dont do this, node objects stay in array, even after queue_free() and free() calls
	playerHands = []
	if dealerHand:
		dealerHand.queue_free()
	deckCount = deckCount
	generateDeck(deckCount)
	shuffleDeck()
	$PlayerBustText.hide()
	$DealerBustText.hide()
	$StartMenu.hide()
	var playerHand = player_hand_scene.instantiate()
	playerHand.connect("get_card_from_deck",dealCard.bind(playerHand))
	playerHand.connect("player_stand", player_stand)
	playerHand.connect("player_bust", player_bust)
	dealerHand = dealer_hand_scene.instantiate()
	dealerHand.connect("dealer_stand",dealer_stand)
	dealerHand.connect("dealer_bust",dealer_bust)
	dealCard(playerHand)
	dealCard(dealerHand, false)
	dealCard(playerHand)
	dealCard(dealerHand)
	add_child(playerHand)
	add_child(dealerHand)
	playerHands.append(playerHand)

func player_stand():
	start_dealer()

func player_bust():
	$PlayerBustText.visible = true
	$StartMenu.visible = true

func dealer_stand():
	if dealerHand.totalHandValue > playerHands[0].totalHandValue:
		player_bust()
	else:
		dealer_bust()

func dealer_bust():
	$DealerBustText.visible = true
	$StartMenu.visible = true
	
func start_dealer():
	dealerHand.showHiddenCard()
	var keepDealing = true
	while keepDealing:
		await get_tree().create_timer(1).timeout
		keepDealing = dealCard(dealerHand)
		
