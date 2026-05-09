extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim = $AnimatedSprite2D
@onready var respawn_point = $"../Respawn_player1"

var current_respawn_position: Vector2

func _ready() -> void:
	global_position = respawn_point.global_position
	current_respawn_position = respawn_point.global_position

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimiento izquierda/derecha
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED

		if direction < 0:
			anim.flip_h = true
		elif direction > 0:
			anim.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animaciones
	if not is_on_floor():
		if anim.animation != "salto":
			anim.play("salto")
	elif direction != 0:
		if anim.animation != "movimiento_lineal":
			anim.play("movimiento_lineal")
	else:
		if anim.animation != "idle":
			anim.play("idle")

	move_and_slide()

	# Respawn al caer fuera del mapa
	if global_position.y > 750:
		respawn()

func respawn() -> void:
	global_position = current_respawn_position
	velocity = Vector2.ZERO
