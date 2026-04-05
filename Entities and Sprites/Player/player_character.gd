extends CharacterBody2D

@export_category("Player Stats")
@export var MoveSpeed = 150.0

var move_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	Player_base_movement()

func Player_base_movement() -> void:
	move_direction.x = int(Input.is_action_pressed("Player_move_right")) - int(Input.is_action_pressed("Player_move_left"))
	move_direction.y = int(Input.is_action_pressed("Player_move_down")) - int(Input.is_action_pressed("Player_move_up"))
	var motion: Vector2 = move_direction.normalized() * MoveSpeed
	set_velocity(motion)
	move_and_slide()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().name.begins_with("test_dummy_interaction"):
		get_tree().change_scene_to_file("res://Battle.tscn")
