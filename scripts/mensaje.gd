extends Label


func mostrar_texto(texto):

	text = texto

	visible = true

	await get_tree().create_timer(2.0).timeout

	visible = false
