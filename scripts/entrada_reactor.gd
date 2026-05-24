extends Area2D

var jugador_cerca = false

@onready var mensaje = get_node("/root/Hubcentral/UI/Mensaje")


func _on_body_entered(body):

	if body.name == "player":

		jugador_cerca = true


func _on_body_exited(body):

	if body.name == "player":

		jugador_cerca = false


func _process(delta):

	if jugador_cerca:

		if Input.is_action_just_pressed("interactuar"):

			if GameManager.acceso_reactor:

				mensaje.mostrar_texto("Entrando al reactor")

			else:

				mensaje.mostrar_texto("Puerta cerrada. Se necesita acceso.")
