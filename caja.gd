extends RigidBody2D

var activada := false

func _physics_process(_delta: float) -> void:
	if global_position.y > 750:
		queue_free()

func activar(tocador: Node2D) -> void:
	if activada:
		return
	activada = true
	tocador.vidas += 1
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		hud.actualizar_vidas(tocador.player_id, tocador.vidas)
	call_deferred("queue_free")
