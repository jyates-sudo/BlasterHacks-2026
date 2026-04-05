extends Node

var bag = Array([], TYPE_OBJECT, "Node", Items)
var cards = Array([], TYPE_OBJECT, "Node", Items)
var cards_owned = Array([], TYPE_OBJECT, "Node", Items)
var init_pick = false
var items_init = false
var wins = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(!items_init):
		_init_items()
		items_init = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _getBag() -> Dictionary:
	print("Got Bag!")
	return bag
func _getCards() -> Array:
	print("Got Cards!")
	return cards

func _init_items() -> void:
	# Monster 1
	var item = Items.new()
	item.item_name = "monster1"
	item.item_description = "Placeholder description"
	item.sprite_loc = "res://assets/1_mon_card.tres"
	item.battle_loc = "res://assets/1_mon_battle.tres"
	cards.append(item)

	# Monster 2
	var item2 = Items.new()
	item2.item_name = "monster2"
	item2.item_description = "Placeholder description"
	item2.sprite_loc = "res://assets/2_mon_card.tres"
	item2.battle_loc = "res://assets/2_mon_battle.tres"
	cards.append(item2)

	# Monster 3
	var item3 = Items.new()
	item3.item_name = "monster3"
	item3.item_description = "Placeholder description"
	item3.sprite_loc = "res://assets/3_mon_card.tres"
	item3.battle_loc = "res://assets/3_mon_battle.tres"
	cards.append(item3)

	# Monster 4
	var item4 = Items.new()
	item4.item_name = "monster4"
	item4.item_description = "Placeholder description"
	item4.sprite_loc = "res://assets/4_mon_card.tres"
	item4.battle_loc = "res://assets/4_mon_battle.tres"
	cards.append(item4)

	# Monster 5
	var item5 = Items.new()
	item5.item_name = "monster5"
	item5.item_description = "Placeholder description"
	item5.sprite_loc = "res://assets/5_mon_card.tres"
	item5.battle_loc = "res://assets/5_mon_battle.tres"
	cards.append(item5)

	# Monster 6
	var item6 = Items.new()
	item6.item_name = "monster6"
	item6.item_description = "Placeholder description"
	item6.sprite_loc = "res://assets/6_mon_card.tres"
	item6.battle_loc = "res://assets/6_mon_battle.tres"
	cards.append(item6)

	# Monster 7
	var item7 = Items.new()
	item7.item_name = "monster7"
	item7.item_description = "Placeholder description"
	item7.sprite_loc = "res://assets/7_mon_card.tres"
	item7.battle_loc = "res://assets/7_mon_battle.tres"
	cards.append(item7)
	
	
