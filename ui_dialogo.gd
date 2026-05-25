extends CanvasLayer

@onready var label_de_texto = $Dialogo/Texto

var lista_dialogos: Array = []
var linea_actual: int = 0
var recien_abierto: bool = false # Nuestro seguro contra doble clic

func _ready():
	visible = false

func _process(_delta):
	# Si la caja de texto está en pantalla, empezamos a escuchar los botones
	if visible:
		# Si acabamos de abrirlo, esperamos a que sueltes el botón primero
		if recien_abierto:
			if not Input.is_action_pressed("interactuar"):
				recien_abierto = false
			return
			
		# Si presionas 'A', avanzamos a la siguiente línea
		if Input.is_action_just_pressed("interactuar"):
			avanzar_dialogo()

func iniciar_dialogo(nuevos_dialogos: Array):
	lista_dialogos = nuevos_dialogos
	linea_actual = 0
	visible = true
	recien_abierto = true # Activamos el seguro al abrir
	mostrar_linea_actual()

func mostrar_linea_actual():
	if linea_actual < lista_dialogos.size():
		label_de_texto.text = lista_dialogos[linea_actual]
	else:
		cerrar_dialogo()

func avanzar_dialogo():
	linea_actual += 1
	mostrar_linea_actual()

func cerrar_dialogo():
	visible = false
	lista_dialogos.clear()
	linea_actual = 0
