extends Control

@onready var label_ganador = $Contenedor/LabelGanador
@onready var btn_repetir = $Contenedor/BtnRepetir
@onready var btn_menu = $Contenedor/BtnMenu

func _ready() -> void:
	label_ganador.text = "¡Jugador %d gana!" % Global.ganador

func _on_btn_repetir_pressed() -> void:
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _on_btn_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
