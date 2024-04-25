extends Node2D
signal dealer_bust
signal dealer_stand
signal dealer_blackjack

var cards = preload("res://scenes/cards.tscn")

var totalHandValue = 0
var cardsInHand = 0
var acesInHand = 0
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
	if card.rank == 1: 
		acesInHand+=1
	
	#Dont increment count if card is not visible
	if !isVisible:
		hiddenCard = cardObject
	else:
		return incrementHandCount(card.rank)
	return true

#double work function (dealer and player)
func incrementHandCount(incVal: int):
	if incVal > 10:
		incVal = 10
	if incVal == 1:
		incVal = 11
		
	totalHandValue+=incVal
	if totalHandValue == 21:
		dealer_blackjack.emit()
		dealer_stand.emit()
	#handle aces over 21
	while totalHandValue > 21 && acesInHand > 0:
		totalHandValue -= 10
		acesInHand -= 1

	if totalHandValue == 17 && acesInHand > 0:
		return true
	if totalHandValue > 21:
		dealer_bust.emit()
		return false
	if totalHandValue > 16:
		dealer_stand.emit()
		return false
	return true

func showHiddenCard() -> bool:
	hiddenCard.setCardVisible(true)
	return incrementHandCount(hiddenCard.cardData.rank)

