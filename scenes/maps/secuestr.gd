extends Area2D

@export var ui_dialogo: CanvasLayer
@export var animador: AnimationPlayer
@export var player: CharacterBody2D
@export var camara_museo: Camera2D 

var cinematica_en_curso = false
var dialogo_iniciado = false # NUEVO: Nuestro "seguro" para evitar el viaje rápido

# Función corregida para secuestr.gd
func _on_body_entered(body):
	if body.name == "player" and not cinematica_en_curso:
		cinematica_en_curso = true
		
		# --- EL FRENAZO DE EMERGENCIA ---
		# Forzamos a cero la velocidad del jugador para que se detenga en seco.
		# Esto asume que tu personaje usa un CharacterBody2D estándar con la variable "velocity".
		if player and "velocity" in player:
			player.velocity = Vector2.ZERO
		
		# --- DESPUÉS, APAGAMOS LA FÍSICA ---
		# Ahora que está quieto, congelamos sus procesos físicos.
		player.set_physics_process(false) 
		
		# --- SIGUE EL RESTO NORMAL ---
		# 3. Activamos la cámara
		camara_museo.enabled = true
		camara_museo.make_current()
		
		# 4. Arrancamos la animación
		animador.play("secuestro")

func iniciar_dialogo_cinematico():
	# Quitamos el seguro porque ahora sí empezó el diálogo
	dialogo_iniciado = true 
	
	ui_dialogo.iniciar_dialogo([
		"(Voz misteriosa): El K-shi-pum es la clave del universo...",
		"¡Un momento! ¿Quién anda ahí?",
		"¡Atrápenlo!"
	])

func _process(_delta):
	if cinematica_en_curso and dialogo_iniciado:
		# Ya no chequeamos botones aquí. El UI lo hace solo.
		# Solo vigilamos si la ventana se cerró para hacer el teletransporte.
		if not ui_dialogo.visible:
			get_tree().change_scene_to_file("res://scenes/maps/Hubcentral.tscn")
