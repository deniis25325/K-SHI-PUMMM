extends Control

@onready var label_resultado = $Resultado
@onready var carta_jugador = $CartaJugador
@onready var carta_alien = $CartaAlien
@onready var btn_piedra = $Piedra
@onready var btn_papel = $Papel
@onready var btn_tijera = $Tijera

@export var img_piedra: Texture2D
@export var img_papel: Texture2D
@export var img_tijera: Texture2D

var imagenes = []
var puntos_jugador = 0
var puntos_alien = 0

func _ready():
	imagenes = [img_piedra, img_papel, img_tijera]
	carta_jugador.visible = false
	carta_alien.visible = false
	
	# TEXTO MEJORADO PARA EXPLICAR LA REGLA
	label_resultado.text = "¡El primero en lograr " + str(GameManager.victorias_necesarias) + " victorias, gana el combate!"
	btn_piedra.grab_focus()

func _on_piedra_pressed(): jugar_ronda(0)
func _on_papel_pressed(): jugar_ronda(1)
func _on_tijera_pressed(): jugar_ronda(2)

func jugar_ronda(eleccion_jugador: int):
	btn_piedra.disabled = true
	btn_papel.disabled = true
	btn_tijera.disabled = true

	var eleccion_alien = randi() % 3

	carta_jugador.texture = imagenes[eleccion_jugador]
	carta_alien.texture = imagenes[eleccion_alien]
	carta_jugador.visible = true
	carta_alien.visible = true

	# Lógica del punto
	if eleccion_jugador == eleccion_alien:
		label_resultado.text = "¡Choque igual! Nadie suma."
	elif (eleccion_jugador == 0 and eleccion_alien == 2) or \
		 (eleccion_jugador == 1 and eleccion_alien == 0) or \
		 (eleccion_jugador == 2 and eleccion_alien == 1):
		label_resultado.text = "¡PUNTO PARA TI!"
		puntos_jugador += 1
	else:
		label_resultado.text = "¡PUNTO PARA EL ALIEN!"
		puntos_alien += 1

	# Marcador actualizado
	label_resultado.text += "\n\nMarcador: " + str(puntos_jugador) + " a " + str(puntos_alien)

	await get_tree().create_timer(1.5).timeout

	# Revisar quién llegó a la meta primero
	if puntos_jugador >= GameManager.victorias_necesarias:
		finalizar(true)
	elif puntos_alien >= GameManager.victorias_necesarias:
		finalizar(false)
	else:
		carta_jugador.visible = false
		carta_alien.visible = false
		
		# Calcular cuántos puntos faltan para hacerlo más emocionante
		var puntos_faltantes = GameManager.victorias_necesarias - puntos_jugador
		if puntos_faltantes == 1:
			label_resultado.text = "¡Estás a 1 punto de ganar!\nElige tu jugada."
		else:
			label_resultado.text = "¡Siguiente ronda!\nElige tu jugada."
		
		btn_piedra.disabled = false
		btn_papel.disabled = false
		btn_tijera.disabled = false
		btn_piedra.grab_focus()

func finalizar(victoria: bool):
	if victoria:
		label_resultado.text = "¡COMBATE TERMINADO!\nHas conseguido la llave."
		GameManager.inventory.append(GameManager.llave_recompensa)
	else:
		label_resultado.text = "¡COMBATE TERMINADO!\nHas sido derrotado."

	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file(GameManager.sala_antes_del_combate)
