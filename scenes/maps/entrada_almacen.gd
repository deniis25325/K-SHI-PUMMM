extends Area2D

@export var escena_destino: String = "res://scenes/maps/almacen.tscn"
@export var llave_necesaria: String = "tarjeta_almacen" 

func _on_body_entered(body):
	if body.name == "player":
		if GameManager.has_item(llave_necesaria):
			# --- LA SOLUCIÓN ESTÁ AQUÍ ---
			# Le pedimos a Godot que espere a terminar las físicas antes de cambiar
			get_tree().call_deferred("change_scene_to_file", escena_destino)
		else:
			print("Puerta bloqueada. Faltan permisos.")
