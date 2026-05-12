extends Control

# Referencias a los botones de selección de jugadores
@onready var btn_2 = $VBoxContainer/HBoxJugadores/Btn2
@onready var btn_3 = $VBoxContainer/HBoxJugadores/Btn3
@onready var btn_4 = $VBoxContainer/HBoxJugadores/Btn4
@onready var btn_jugar = $VBoxContainer/BtnJugar
@onready var label_seleccion = $VBoxContainer/LabelSeleccion

var jugadores_seleccionados: int = 2

func _ready() -> void:
	_actualizar_botones()

func _on_btn2_pressed() -> void:
	jugadores_seleccionados = 2
	_actualizar_botones()

func _on_btn3_pressed() -> void:
	jugadores_seleccionados = 3
	_actualizar_botones()

func _on_btn4_pressed() -> void:
	jugadores_seleccionados = 4
	_actualizar_botones()

func _on_btn_jugar_pressed() -> void:
	Global.num_jugadores = jugadores_seleccionados
	get_tree().change_scene_to_file("res://node_2d.tscn")

func _actualizar_botones() -> void:
	label_seleccion.text = "Jugadores: %d" % jugadores_seleccionados

	# Resaltar el botón activo cambiando la modulate
	btn_2.modulate = Color.WHITE if jugadores_seleccionados != 2 else Color(0.4, 1.0, 0.4)
	btn_3.modulate = Color.WHITE if jugadores_seleccionados != 3 else Color(0.4, 1.0, 0.4)
	btn_4.modulate = Color.WHITE if jugadores_seleccionados != 4 else Color(0.4, 1.0, 0.4)
