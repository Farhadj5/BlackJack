class_name PlayingCardData extends Resource

@export var suit:String

@export var rank:int

var numToName = {10: "Ten", 11: "Jack", 12: "Queen", 13: "King", 1: "Ace"}
func _init(suit:String, rank:int):
	self.suit = suit
	self.rank = rank

func printCard() -> String:
	var cardText = ""
	if rank > 10 || rank == 1:
		cardText = "%s of %s" % [numToName[rank],suit]
	else:
		cardText = "%d of %s" % [rank, suit]
		
	return cardText

func printCardShortHand() -> String:
	var cardText = ""
	if rank in numToName:
		cardText = "%s%s" % [numToName[rank][0],suit[0]]
	else:
		cardText = "%d%s" % [rank, suit[0]]
		
	return cardText

