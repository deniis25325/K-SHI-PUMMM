extends Area2D

# 1. Arrastras tu nodo UI_Dialogo aquí en el Inspector
@export var ui_dialogo: CanvasLayer

# 2. Configuras la pelea en el Inspector
@export var rondas_para_ganar: int = 1
@export var llave_que_da: String = "tarjeta_laboratorio"

# 3. Textos directos del alien (los puedes cambiar en el Inspector)
@export var lineas_dialogo: Array[String] = [
	"¡Humano insensato! No deberías haber salido de tu celda...",
	"¡Nadie pasa de aquí sin vencerme en el duelo ancestral!",
	"¡Prepárate para el K-shi-pum!"
]

var jugador_cerca = false
var charla_iniciada = false
var player_ref: CharacterBody2D = null

func _process(_delta):
	# Cuando presionamos interactuar al estar cerca
	if jugador_cerca and Input.is_action_just_pressed("interactuar") and not charla_iniciada:
		if ui_dialogo and not ui_dialogo.visible:
			charla_iniciada = true
			
			# Detenemos al jugador usando tu variable
			if player_ref:
				if "velocity" in player_ref:
					player_ref.velocity = Vector2.ZERO
				player_ref.puede_moverse = false
			
			# Lanzamos el texto exacto que pusimos arriba
			ui_dialogo.iniciar_dialogo(lineas_dialogo)
	
	# Cuando el texto se termina y la ventana desaparece
	if charla_iniciada and not ui_dialogo.visible:
		# Guardamos los datos en tu GameManager
		GameManager.victorias_necesarias = rondas_para_ganar
		GameManager.llave_recompensa = llave_que_da
		GameManager.sala_antes_del_combate = get_tree().current_scene.scene_file_path
		
		# Viajamos a la arena de combate
		get_tree().call_deferred("change_scene_to_file", "res://scenes/maps/combate.tscn")

func _on_body_entered(body):
	# Usamos el nombre exacto como tú prefieres
	if body.name == "player":
		jugador_cerca = true
		player_ref = body

func _on_body_exited(body):
	if body.name == "player":
		jugador_cerca = false
		if not charla_iniciada:
			player_ref = null
