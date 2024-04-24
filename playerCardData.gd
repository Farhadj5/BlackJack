class_name PlayingCardData extends Resource

@export var suit:String

@export var rank:int

var numToName = {11: "Jack", 12: "Queen", 13: "King", 14: "Ace"}
var numToShortHand = {10: "T", 11: "J", 12: "Q", 13: "K", 14: "A"}
func _init(suit:String, rank:int):
	self.suit = suit
	self.rank = rank

func printCard() -> String:
	var cardText = ""
	if rank > 10:
		cardText = "%s of %s" % [numToName[rank],suit]
	else:
		cardText = "%d of %s" % [rank, suit]
		
	return cardText

func printCardShortHand() -> String:
	var cardText = ""
	if rank > 9:
		cardText = "%s%s" % [numToShortHand[rank],suit[0]]
	else:
		cardText = "%d%s" % [rank, suit[0]]
		
	return cardText

