extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	GameManager.escena_actual = scene_file_path

	GameManager.guardar_partida()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_entrada_enfermeria_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
