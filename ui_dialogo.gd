extends CanvasLayer

# --- ESTO ES LO MÁS IMPORTANTE ---
# Tienes que arrastrar tu nodo Label desde el árbol de escena 
# hacia aquí, o escribir la ruta correcta para que Godot lo encuentre.
@onready var label_de_texto = $Dialogo/Texto

var lista_dialogos: Array = []
var linea_actual: int = 0

func _ready():
	visible = false

func iniciar_dialogo(nuevos_dialogos: Array):
	lista_dialogos = nuevos_dialogos
	linea_actual = 0
	visible = true
	mostrar_linea_actual()

func mostrar_linea_actual():
	if linea_actual < lista_dialogos.size():
		var texto_nuevo = lista_dialogos[linea_actual]
		
		# AQUÍ OCURRE LA MAGIA: 
		# Reemplazamos el texto base del Label por el texto que mandó el NPC
		label_de_texto.text = texto_nuevo 
		
	else:
		cerrar_dialogo()

func avanzar_dialogo():
	linea_actual += 1
	mostrar_linea_actual()

func cerrar_dialogo():
	visible = false
	lista_dialogos.clear()
	linea_actual = 0
