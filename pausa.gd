extends CanvasLayer

# Este nodo se añade a node_2d.tscn
# Su capa (layer) debe ser alta (ej: 10) para estar encima de todo

@onready var panel_pausa = $PanelPausa

func _ready() -> void:
	panel_pausa.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
		_toggle_pausa()

func _toggle_pausa() -> void:
	var pausado = not get_tree().paused
	get_tree().paused = pausado
	if pausado:
		panel_pausa.show()
	else:
		panel_pausa.hide()

func _on_btn_reanudar_pressed() -> void:
	_toggle_pausa()

func _on_btn_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
