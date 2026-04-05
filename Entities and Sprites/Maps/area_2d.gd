extends Area2D

@export_file("*.tscn") var target_room: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(self.overlaps_body(get_node("../player character"))):
		if(target_room != ""):
			get_tree().change_scene_to_file(target_room)
