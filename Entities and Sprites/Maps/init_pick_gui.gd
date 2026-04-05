extends CanvasLayer

signal card_selected(choice_data)

@onready var card_1: TextureButton = $Control/CenterContainer/HBoxContainer/TextureButton
@onready var card_2: TextureButton = $Control/CenterContainer/HBoxContainer/TextureButton2
@onready var card_3: TextureButton = $Control/CenterContainer/HBoxContainer/TextureButton3

var choices: Array = []

func _ready() -> void:
	card_1.pressed.connect(_on_card_pressed.bind(0))
	card_2.pressed.connect(_on_card_pressed.bind(1))
	card_3.pressed.connect(_on_card_pressed.bind(2))

func set_choices(new_choices: Array) -> void:

	choices = new_choices

	if choices.size() < 3:
		push_error("CardChoiceGUI requires exactly 3 choices.")
		return

	_apply_choice_to_button(card_1, choices[0])
	_apply_choice_to_button(card_2, choices[1])
	_apply_choice_to_button(card_3, choices[2])

func _apply_choice_to_button(button: TextureButton, choice: Dictionary) -> void:
	if choice.has("texture"):
		button.texture_normal = choice["texture"]
		button.texture_hover = choice["texture"]
		button.texture_pressed = choice["texture"]
		button.texture_disabled = choice["texture"]

	if choice.has("disabled") and choice["disabled"] == true:
		button.disabled = true
	else:
		button.disabled = false

func _on_card_pressed(index: int) -> void:
	if index >= choices.size():
		return

	card_selected.emit(choices[index])
	queue_free()
