extends CanvasLayer

@onready var vidas_p1 = $BarraVidas/HUDPlayer1/VidasP1
@onready var vidas_p2 = $BarraVidas/HUDPlayer2/VidasP2
@onready var vidas_p3 = $BarraVidas/HUDPlayer3/VidasP3
@onready var vidas_p4 = $BarraVidas/HUDPlayer4/VidasP4
@onready var hud_p3 = $BarraVidas/HUDPlayer3
@onready var hud_p4 = $BarraVidas/HUDPlayer4

func _ready() -> void:
	add_to_group("hud")
	var num = Global.num_jugadores
	hud_p3.visible = num >= 3
	hud_p4.visible = num >= 4

func actualizar_vidas(player_id: int, vidas: int) -> void:
	match player_id:
		1: vidas_p1.text = "%d" % vidas
		2: vidas_p2.text = "%d" % vidas
		3: vidas_p3.text = "%d" % vidas
		4: vidas_p4.text = "%d" % vidas
