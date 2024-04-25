extends Node2D
signal get_card_from_deck
signal player_stand
signal player_bust

var cards = preload("res://scenes/cards.tscn")

var totalHandValue = 0
var cardsInHand = 0

#double work function (dealer and player)
func dealCard(card: PlayingCardData, isVisible: bool):
	var cardObject = cards.instantiate()
	cardObject.position = $PlayerHandStart.position
	cardObject.position.x += Global.xIncrement * cardsInHand
	cardObject.position.y += Global.yIncrement * cardsInHand
	cardObject.setCard(card, isVisible)
	add_child(cardObject)
	cardsInHand+=1
	incrementHandCount(card.rank)
	return true
	
#double work function (dealer and player)
func incrementHandCount(incVal: int):
		if incVal > 10:
			incVal = 10
		totalHandValue+=incVal
		if totalHandValue > 21:
			player_bust.emit()

func _on_hit_pressed():
	get_card_from_deck.emit()


func _on_stand_pressed():
	player_stand.emit()
