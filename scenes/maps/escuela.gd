extends Node2D
@onready var pause_menu = $CanvasLayer/PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):

		if get_tree().paused:

			pause_menu.cerrar_menu()

		else:

			pause_menu.abrir_menu()
