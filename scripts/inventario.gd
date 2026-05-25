extends CanvasLayer

@onready var panel = $Panel
@onready var label_items = $Panel/Label

func _ready():
	# El panel empieza oculto
	panel.visible = false

# 1. Esto funciona si haces clic en el botón de la pantalla con el ratón
func _on_button_pressed():
	alternar_inventario()

# 2. Esto funciona si presionas la tecla "I" en tu teclado
func _input(event):
	if event.is_action_pressed("abrir_inventario"):
		alternar_inventario()

# La función central que abre o cierra el panel
func alternar_inventario():
	panel.visible = !panel.visible 
	
	if panel.visible:
		actualizar_inventario()

func actualizar_inventario():
	# Revisamos qué hay guardado en el GameManager
	if GameManager.inventory.size() == 0:
		label_items.text = "Inventario vacío.\n¡Aún no tienes nada!"
	else:
		var texto_final = "TUS OBJETOS:\n\n"
		for objeto in GameManager.inventory:
			texto_final += "- " + str(objeto) + "\n"
		label_items.text = texto_final
