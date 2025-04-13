extends Control

@onready var panel = $Panel
@onready var label = $Panel/Label

func show_tooltip(text: String, position: Vector2):
	label.text = text
	global_position = position
	visible = true

func hide_tooltip():
	visible = false

func _process(delta: float) -> void:
	if visible:
		global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
