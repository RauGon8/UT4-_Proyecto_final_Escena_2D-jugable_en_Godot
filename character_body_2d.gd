extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var player_id: int = 1

@onready var anim = $AnimatedSprite2D
@onready var respawn_point = $"../Respawn_player1"

var current_respawn_position: Vector2
var vidas: int = 3

func _ready() -> void:
	global_position = respawn_point.global_position
	current_respawn_position = respawn_point.global_position

func _physics_process(delta: float) -> void:
	var accion_izquierda = "p%d_izquierda" % player_id
	var accion_derecha = "p%d_derecha" % player_id
	var accion_salto = "p%d_salto" % player_id

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(accion_salto) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis(accion_izquierda, accion_derecha)

	if direction != 0:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

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

	if global_position.y > 750:
		perder_vida()

func perder_vida() -> void:
	vidas -= 1
	global_position = current_respawn_position
	velocity = Vector2.ZERO
	
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		hud.actualizar_vidas(player_id, vidas)
	
	if vidas <= 0:
		queue_free()
