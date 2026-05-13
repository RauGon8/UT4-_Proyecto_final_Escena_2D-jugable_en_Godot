extends Area2D

@export var fuerza_horizontal: float = 800.0
@export var fuerza_vertical: float = -400.0
@export var duracion: float = 1.0

var direccion_empuje: Vector2 = Vector2.LEFT

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("default")
	anim.flip_h = direccion_empuje.x > 0
	get_tree().create_timer(duracion).timeout.connect(queue_free)

func _physics_process(_delta: float) -> void:
	var mirando_derecha = direccion_empuje.x > 0
	var fuerza = fuerza_horizontal if mirando_derecha else -fuerza_horizontal

	for cuerpo in get_overlapping_bodies():
		if not cuerpo.is_in_group("jugadores"):
			continue

		var resistiendo = (mirando_derecha and cuerpo.empuje_recibido + cuerpo.velocity.x < 0) or \
						  (not mirando_derecha and cuerpo.empuje_recibido + cuerpo.velocity.x > 0)

		cuerpo.empuje_recibido = fuerza

		if direccion_empuje.y > 0.3:
			cuerpo.velocity.y = fuerza_vertical
