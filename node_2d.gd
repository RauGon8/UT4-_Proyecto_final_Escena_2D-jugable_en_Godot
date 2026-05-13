extends Node2D

@onready var player1 = $player1
@onready var player2 = $player2
@onready var player3 = $player3
@onready var player4 = $player4

var jugadores: Array

func _ready() -> void:
	var num = Global.num_jugadores

	player3.visible = num >= 3
	player3.process_mode = Node.PROCESS_MODE_INHERIT if num >= 3 else Node.PROCESS_MODE_DISABLED

	player4.visible = num >= 4
	player4.process_mode = Node.PROCESS_MODE_INHERIT if num >= 4 else Node.PROCESS_MODE_DISABLED

	jugadores = [player1, player2]
	if num >= 3: jugadores.append(player3)
	if num >= 4: jugadores.append(player4)

func _process(_delta: float) -> void:
	var vivos = jugadores.filter(func(p): return is_instance_valid(p))
	if vivos.size() == 1:
		Global.ganador = vivos[0].player_id
		get_tree().change_scene_to_file("res://fin.tscn")
