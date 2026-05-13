extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const FUERZA_EMPUJE = 250

@export var player_id: int = 1

@onready var anim = $AnimatedSprite2D
@onready var zona_empuje = $ZonaEmpuje

var respawn_point: Node2D
var current_respawn_position: Vector2
var vidas: int = 3
var mirando_derecha: bool = true
var empuje_recibido: float = 0.0

func _ready() -> void:
	respawn_point = get_node("../Respawn_player%d" % player_id)
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
	velocity.x = direction * SPEED + empuje_recibido
	empuje_recibido = 0.0

	if direction != 0:
		anim.flip_h = direction < 0
		mirando_derecha = direction > 0
		zona_empuje.scale.x = 1 if mirando_derecha else -1

	if not is_on_floor():
		if anim.animation != "salto":
			anim.play("salto")
	elif direction != 0:
		if anim.animation != "movimiento_lineal":
			anim.play("movimiento_lineal")
	else:
		if anim.animation != "idle":
			anim.play("idle")

	_aplicar_empuje()
	move_and_slide()
	_comprobar_colision_caja()

	if global_position.y > 750:
		perder_vida()

func _aplicar_empuje() -> void:
	var cuerpos = zona_empuje.get_overlapping_bodies()
	for cuerpo in cuerpos:
		if cuerpo == self:
			continue
		if cuerpo.is_in_group("jugadores"):
			var fuerza = FUERZA_EMPUJE if mirando_derecha else -FUERZA_EMPUJE
			var resistiendo = (mirando_derecha and cuerpo.empuje_recibido + cuerpo.velocity.x < 0) or (not mirando_derecha and cuerpo.empuje_recibido + cuerpo.velocity.x > 0)
			cuerpo.empuje_recibido = fuerza

func _comprobar_colision_caja() -> void:
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		var collider = col.get_collider()
		if collider and collider.has_method("activar"):
			collider.activar(self)

func perder_vida() -> void:
	vidas -= 1
	global_position = current_respawn_position
	velocity = Vector2.ZERO
	empuje_recibido = 0.0
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		hud.actualizar_vidas(player_id, vidas)
	if vidas <= 0:
		queue_free()
