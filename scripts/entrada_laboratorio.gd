extends Area2D

func _on_body_entered(body):
	print(body.name)

	if body.name == "player":
		get_tree().change_scene_to_file("res://scenes/maps/laboratorio.tscn")
