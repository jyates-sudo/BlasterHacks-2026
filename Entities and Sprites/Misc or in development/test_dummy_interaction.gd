extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

var has_talked: bool = false

func _ready() -> void:
	interactable.interact = _on_interact
	

func _on_interact():
	get_tree().change_scene_to_file("res://Battle.tscn")
