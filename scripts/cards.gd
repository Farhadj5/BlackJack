extends Node2D


var cardSprite = null;
var cardData: PlayingCardData = null
func setCardVisible(isVisible: bool):
	$BackOfCardSprite.visible = !isVisible

func setCard(card : PlayingCardData, isVisible: bool):
	cardData = card
	setCardVisible(isVisible)
	match card.suit:
		Global.Suit.HEART:
			cardSprite = $HeartsSprite
		Global.Suit.DIAMOND:
			cardSprite = $DiamondsSprite
		Global.Suit.CLUB:
			cardSprite = $ClubsSprite
		Global.Suit.SPADE:
			cardSprite = $SpadesSprite
	cardSprite.visible = true
	cardSprite.frame = card.rank-1
