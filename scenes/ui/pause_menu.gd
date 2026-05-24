extends Control


func _ready():
	visible = false


func abrir_menu():

	visible = true

	get_tree().paused = true

	$VBoxContainer/Continuar.grab_focus()



func cerrar_menu():

	visible = false

	get_tree().paused = false



func _on_continuar_pressed():

	cerrar_menu()



func _on_guardar_pressed():

	GameManager.guardar_partida()



func _on_cargar_pressed():

	get_tree().paused = false

	GameManager.cargar_partida()



func _on_menu_principal_pressed():

	get_tree().paused = false

	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
