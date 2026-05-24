extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MenuButtons/NuevaPartida.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_nueva_partida_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/maps/escuela.tscn")


func _on_cargar_partida_pressed() -> void:
	GameManager.cargar_partida()


func _on_opciones_pressed() -> void:
	pass # Replace with function body.


func _on_salir_pressed() -> void:
	get_tree().quit()
