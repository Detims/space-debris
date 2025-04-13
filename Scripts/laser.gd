extends Area2D

class_name Laser

@export var speed = 500

func _process(delta):
	position.y -= delta * speed
