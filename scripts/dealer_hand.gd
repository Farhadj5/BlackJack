extends Node2D
signal dealer_bust
signal dealer_stand

var cards = preload("res://scenes/cards.tscn")

var totalHandValue = 0
var cardsInHand = 0
var hiddenCard: Node = null

#double work function (dealer and player)
func dealCard(card: PlayingCardData, isVisible: bool) -> bool:
	var cardObject = cards.instantiate()

	cardObject.position = $DealerHandStart.position
	cardObject.position.x += Global.xIncrement * cardsInHand
	cardObject.position.y += Global.yIncrement * cardsInHand
	cardObject.setCard(card, isVisible)
	add_child(cardObject)
	cardsInHand+=1
	if !isVisible:
		hiddenCard = cardObject
	else:
		return incrementHandCount(card.rank)
	return true

#double work function (dealer and player)
func incrementHandCount(incVal: int):
	if incVal > 10:
		incVal = 10
	totalHandValue+=incVal
	if totalHandValue > 21:
		dealer_bust.emit()
		return false
	if totalHandValue > 16:
		dealer_stand.emit()
		return false
	return true

func showHiddenCard():
	hiddenCard.setCardVisible(true)
	incrementHandCount(hiddenCard.cardData.rank)

