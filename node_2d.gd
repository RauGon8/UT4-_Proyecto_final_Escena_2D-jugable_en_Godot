extends Node2D

@onready var player1 = $player1
@onready var player2 = $player2
@onready var player3 = $player3
@onready var player4 = $player4

func _ready() -> void:
	var num = Global.num_jugadores

	player3.visible = num >= 3
	player3.process_mode = Node.PROCESS_MODE_INHERIT if num >= 3 else Node.PROCESS_MODE_DISABLED

	player4.visible = num >= 4
	player4.process_mode = Node.PROCESS_MODE_INHERIT if num >= 4 else Node.PROCESS_MODE_DISABLED
