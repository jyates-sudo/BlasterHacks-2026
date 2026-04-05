extends Node2D

@export var zone_size: Vector2 = Vector2(300, 200)
@export var min_spacing: float = 32.0
@export var max_attempts: int = 30

func get_spawn_position(existing_nodes: Array[Node2D]) -> Vector2:
	var half = zone_size * 0.5

	for i in max_attempts:
		var candidate = global_position + Vector2(
			randf_range(-half.x, half.x),
			randf_range(-half.y, half.y)
		)

		var valid = true
		for node in existing_nodes:
			if not is_instance_valid(node):
				continue
			if candidate.distance_to(node.global_position) < min_spacing:
				valid = false
				break

		if valid:
			return candidate

	# fallback if zone is crowded
	return global_position
