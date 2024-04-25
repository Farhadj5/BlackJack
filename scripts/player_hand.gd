extends Node2D
signal get_card_from_deck
signal player_stand
signal player_bust
signal player_blackjack

var cards = preload("res://scenes/cards.tscn")

var totalHandValue = 0
var cardsInHand = 0
var acesInHand = 0

#double work function (dealer and player)
func dealCard(card: PlayingCardData, isVisible: bool):
	var cardObject = cards.instantiate()
	cardObject.position = $PlayerHandStart.position
	cardObject.position.x += Global.xIncrement * cardsInHand
	cardObject.position.y += Global.yIncrement * cardsInHand
	cardObject.setCard(card, isVisible)
	add_child(cardObject)
	cardsInHand+=1
	if card.rank == 1: 
		acesInHand+=1
	incrementHandCount(card.rank)
	return true
	
#double work function (dealer and player)
func incrementHandCount(incVal: int):
		if incVal > 10:
			incVal = 10
		if incVal == 1:
			incVal = 11
		totalHandValue+=incVal
			#handle aces over 21
		while totalHandValue > 21 && acesInHand > 0:
			totalHandValue -= 10
			acesInHand -= 1
		if totalHandValue > 21:
			player_bust.emit()
		if totalHandValue == 21:
			player_blackjack.emit()

func _on_hit_pressed():
	get_card_from_deck.emit()


func _on_stand_pressed():
	player_stand.emit()
