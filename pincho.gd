extends StaticBody2D

@onready var area = $Area2D

var jugadores_en_cooldown := []

func _physics_process(_delta: float) -> void:
	for cuerpo in area.get_overlapping_bodies():
		if cuerpo.is_in_group("jugadores") and not cuerpo in jugadores_en_cooldown:
			jugadores_en_cooldown.append(cuerpo)
			cuerpo.perder_vida()
			_iniciar_cooldown(cuerpo)

func _iniciar_cooldown(cuerpo: Node) -> void:
	await get_tree().create_timer(1.0).timeout
	if is_instance_valid(cuerpo):
		jugadores_en_cooldown.erase(cuerpo)
