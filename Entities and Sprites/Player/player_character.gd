extends CharacterBody2D

@export_category("Player Stats")
@export var MoveSpeed = 300.0

var move_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	Player_base_movement()

func Player_base_movement() -> void:
	move_direction.x = int(Input.is_action_pressed("Player_move_right")) - int(Input.is_action_pressed("Player_move_left"))
	move_direction.y = int(Input.is_action_pressed("Player_move_down")) - int(Input.is_action_pressed("Player_move_up"))
	var motion: Vector2 = move_direction.normalized() * MoveSpeed
	set_velocity(motion)
	move_and_slide()
