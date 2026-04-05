extends ProgressBar
@onready var user = get_node("/root/User")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var style_box = get_theme_stylebox("fill").duplicate() # Duplicate to avoid affecting other bars
	style_box.bg_color = Color.RED
	add_theme_stylebox_override("fill", style_box)
	self.max_value = max_value + (user.wins * randi_range(10, 50))
	self.value = max_value
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
