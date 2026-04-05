extends StaticBody2D


func _on_area_2d_body_entered(body) -> void:
	if body is CharacterBody2D:
		get_tree().change_scene_to_file("res://Battle.tscn")
		print("hello world")
