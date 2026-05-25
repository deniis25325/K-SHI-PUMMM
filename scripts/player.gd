extends CharacterBody2D
var puede_moverse: bool = true
@export var speed = 120

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Si alguien apagó esta variable, frenamos en seco
	if not puede_moverse:
		velocity = Vector2.ZERO
		move_and_slide()
		return # Esto hace que ignore los botones del teclado
	

	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	if Input.is_action_pressed("ui_left"):
		direction.x -= 1

	if Input.is_action_pressed("ui_down"):
		direction.y += 1

	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

	update_animation(direction)

func update_animation(direction):

	if direction == Vector2.ZERO:
		sprite.stop()
		return

	if abs(direction.x) > abs(direction.y):

		if direction.x > 0:
			sprite.play("right")
		else:
			sprite.play("left")

	else:

		if direction.y > 0:
			sprite.play("down")
		else:
			sprite.play("up")
