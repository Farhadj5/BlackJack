extends Node2D
signal get_card_from_deck
var clubs = preload("res://scenes/clubs.tscn")
var hearts = preload("res://scenes/hearts.tscn")
var spades = preload("res://scenes/spades.tscn")
var diamonds = preload("res://scenes/diamonds.tscn")

var totalHandValue = 0
var cardsInHand = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func display_card(card : PlayingCardData):
	var cardObject = null
	match card.suit:
		Global.Suit.HEART:
			cardObject = hearts.instantiate()
		Global.Suit.DIAMOND:
			cardObject = diamonds.instantiate()
		Global.Suit.SPADE:
			cardObject = spades.instantiate()
		Global.Suit.CLUB:
			cardObject = clubs.instantiate()
	cardObject.position = $PlayerHandStart.position
	cardObject.position.x += Global.xIncrement * cardsInHand
	cardObject.position.y += Global.yIncrement * cardsInHand
	cardObject.setCardRank(card.rank)
	add_child(cardObject)
	cardsInHand+=1
	totalHandValue+=card.rank
	print(totalHandValue)


func _on_hit_pressed():
	get_card_from_deck.emit()
