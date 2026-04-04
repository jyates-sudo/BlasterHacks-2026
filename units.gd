extends CanvasLayer
@onready var units = Array([], TYPE_NODE_PATH, "", null)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_children())
	
	_initPaths()
	var unit = units.pick_random()
	get_node(unit).visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _initPaths() -> void:
	units.append(get_node("CanvasGroup").get_path())
	units.append(get_node("CanvasGroup2").get_path())
	units.append(get_node("CanvasGroup3").get_path())
	units.append(get_node("CanvasGroup4").get_path())
	units.append(get_node("CanvasGroup5").get_path())
