extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_gallery_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/gallery.tscn")
