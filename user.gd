extends Node

var bag = {}
var cards = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bag["Potion"] = "Heal a Creature 10 HP"
	bag["Net"] = "Try to Catch a Creature"
	bag["Sword"] = "Increase a Creature's Damage for a Turn"
	cards["Creature1"] = "Creature 1"
	cards["Creature2"] = "Creature 2"
	cards["Creature3"] = "Creature 3"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _getBag() -> Dictionary:
	print("Got Bag!")
	return bag
func _getCards() -> Dictionary:
	print("Got Cards!")
	return cards
	
