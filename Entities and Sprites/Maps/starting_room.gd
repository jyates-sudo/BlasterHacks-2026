extends Node2D

@export var room_size: Vector2 = Vector2(776, 423)

func get_room_rect() -> Rect2:
	return Rect2(global_position, room_size)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var user = get_node("/root/User")
	_give_init_pick()
	print("Room global pos: ", global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _give_init_pick() -> void:
	var gui = get_node("./InitPickGui")
	var user = get_node("/root/User")
	user.cards.shuffle()
	gui.set_choices([
		{
			"name": user.cards[0].item_name,
			"id": user.cards[0].item_description,
			"texture": load(user.cards[0].sprite_loc),
			"item": user.cards[0]
		},
		{
			"name": user.cards[1].item_name,
			"id": user.cards[1].item_description,
			"texture": load(user.cards[1].sprite_loc),
			"item": user.cards[1]
		},
		{
			"name": user.cards[2].item_name,
			"id": user.cards[2].item_description,
			"texture": load(user.cards[2].sprite_loc),
			"item": user.cards[2]
		}
	])

	gui.card_selected.connect(_on_card_choice_selected)

func _on_card_choice_selected(choice_data: Dictionary) -> void:
	print("Player picked: ", choice_data["name"])
	var user = get_node("/root/User")
	user.cards_owned.append(choice_data["item"])
	print(user.cards_owned)
	
	
