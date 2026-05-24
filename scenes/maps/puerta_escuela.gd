extends Area2D

@export var escena_siguiente: String = "res://scenes/maps/escuela.tscn"

func _on_body_entered(body):
	if body.name == "player":
		get_tree().call_deferred("change_scene_to_file", escena_siguiente)
