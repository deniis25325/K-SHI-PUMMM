extends Label

func _process(_delta):

	text = "Inventario:\n"

	for item in GameManager.inventory:

		text += "- " + item + "\n"
