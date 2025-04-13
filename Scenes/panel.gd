extends Control

#@export var tooltip_text: String

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	get_tree().root.get_node("Tooltip").show_tooltip(tooltip_text, get_global_mouse_position())

func _on_mouse_exited():
	get_tree().root.get_node("Tooltip").hide_tooltip()
