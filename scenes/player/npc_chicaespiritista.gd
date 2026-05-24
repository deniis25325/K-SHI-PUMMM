extends Node2D

@export var ui_dialogo: CanvasLayer

var jugador_cerca = false

func _process(delta):
	if jugador_cerca and Input.is_action_just_pressed("interactuar"):
		# Si ya está visible, lo cerramos. Si no, lo abrimos.
		if ui_dialogo.visible:
			ui_dialogo.cerrar_dialogo()
		else:
			mostrar_dialogo()

func mostrar_dialogo():
	# Aquí le mandamos los textos exactos a la UI
	ui_dialogo.iniciar_dialogo([
		"Recuerda que la tarea es para mañana, asi que a hacerla :)"
	])

func _on_area_2d_body_entered(body):
	if body.name == "player":
		jugador_cerca = true

func _on_area_2d_body_exited(body):
	if body.name == "player":
		jugador_cerca = false
