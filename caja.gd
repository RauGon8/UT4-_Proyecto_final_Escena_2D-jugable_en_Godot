extends RigidBody2D

@export var ventilador_scene: PackedScene
@export var offset_distancia: float = 60.0

var activada := false

func _physics_process(_delta: float) -> void:
	if global_position.y > 750:
		queue_free()

func activar(tocador: Node2D) -> void:
	if activada:
		return
	activada = true
	call_deferred("_spawnear_ventilador_para", tocador)
	call_deferred("queue_free")

func _spawnear_ventilador_para(tocador: Node2D) -> void:
	var todos = get_tree().get_nodes_in_group("jugadores")
	var enemigos = todos.filter(func(j):
		return j != tocador and j.process_mode != Node.PROCESS_MODE_DISABLED
	)
	if enemigos.is_empty():
		return
	var objetivo: Node2D = enemigos.pick_random()
	if not is_instance_valid(objetivo):
		return

	var offsets = [
		Vector2(offset_distancia, 0),
		Vector2(-offset_distancia, 0),
		Vector2(0, -offset_distancia),
		Vector2(0, offset_distancia),
	]
	var offset = offsets.pick_random()

	var ventilador = ventilador_scene.instantiate()
	get_parent().add_child(ventilador)
	ventilador.global_position = objetivo.global_position + offset
	ventilador.direccion_empuje = -offset.normalized()
