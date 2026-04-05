extends CharacterBody2D

var current_room: Node2D = null

func set_current_room(room: Node2D) -> void:
	current_room = get_parent()

	if has_node("Camera2D"):
		$Camera2D.update_room_limits()

@export_category("Player Stats")
@export var MoveSpeed = 300.0
@onready var sprite = get_node("AnimatedSprite2D")
enum direction{UP, DOWN, LEFT, RIGHT}
var dir = direction.UP

var move_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	Player_base_movement()
	if(dir == direction.UP):
		if(move_direction == Vector2.ZERO):
			sprite.play("idle_up")
		else:
			sprite.play("walk_up")
	elif(dir == direction.DOWN):
		if(move_direction == Vector2.ZERO):
			sprite.play("idle_down")
		else:
			sprite.play("walk_down")
	elif(dir == direction.LEFT):
		if(move_direction == Vector2.ZERO):
			sprite.play("idle_left")
		else:
			sprite.play("walk_left")
	if(dir == direction.RIGHT):
		if(move_direction == Vector2.ZERO):
			sprite.play("idle_right")
		else:
			sprite.play("walk_right")
		
	
	
func Player_base_movement() -> void:
	move_direction.x = int(Input.is_action_pressed("Player_move_right")) - int(Input.is_action_pressed("Player_move_left"))
	move_direction.y = int(Input.is_action_pressed("Player_move_down")) - int(Input.is_action_pressed("Player_move_up"))
	var motion: Vector2 = move_direction.normalized() * MoveSpeed
	
	if(motion.y < 0 ):
		dir = direction.UP
	elif(motion.y > 0):
		dir = direction.DOWN
	elif(motion.x < 0):
		dir = direction.LEFT
	elif(motion.x > 0):
		dir = direction.RIGHT
		
	
	set_velocity(motion)
	move_and_slide()
