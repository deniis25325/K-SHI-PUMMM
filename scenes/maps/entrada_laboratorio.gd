extends Area2D

var jugador_cerca = false

@onready var mensaje = get_tree().get_root().get_node("Hubcentral/UI/Mensaje")


func _on_body_entered(body):

	if body.name == "player":

		jugador_cerca = true


func _on_body_exited(body):

	if body.name == "player":

		jugador_cerca = false


func _process(_delta):

	if jugador_cerca:

		if Input.is_action_just_pressed("interactuar"):

			if GameManager.acceso_laboratorio:

				mensaje.mostrar_texto("Entrando al área del Laboratorio...")

			else:

				mensaje.mostrar_texto("Se necesita la llave de acceso del Laboratorio")
