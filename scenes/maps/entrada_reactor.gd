extends Area2D

var jugador_cerca = false

@export var escena_reactor = "res://scenes/maps/reactor.tscn"

@onready var mensaje = get_tree().get_root().get_node("Hubcentral/UI/Mensaje")

func _on_body_entered(body):
	if body.name == "player":
		jugador_cerca = true

func _on_body_exited(body):
	if body.name == "player":
		jugador_cerca = false

func _process(_delta):

	if jugador_cerca and Input.is_action_just_pressed("interactuar"):

		# SI YA ESTÁ DESBLOQUEADO → ENTRA DIRECTO
		if GameManager.acceso_reactor:
			mensaje.mostrar_texto("Entrando al Reactor...")
			get_tree().change_scene_to_file(escena_reactor)
			return

		# SI NO ESTÁ DESBLOQUEADO → REVISAR INVENTARIO
		if GameManager.has_item("Llave Reactor"):

			GameManager.acceso_reactor = true
			mensaje.mostrar_texto("Acceso desbloqueado. Entrando al Reactor...")

			await get_tree().create_timer(0.5).timeout
			get_tree().change_scene_to_file(escena_reactor)

		else:
			mensaje.mostrar_texto("Se necesita la llave de acceso del reactor")
