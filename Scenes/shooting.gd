extends Node2D

@export var laser_scene: PackedScene
@export var fire_offset = Vector2(0, -20)  # Adjust this to position your laser correctly
@export var fire_cooldown = 0.2  # Seconds between shots
var can_fire = true

func _process(delta):
	if Input.is_action_pressed("shoot") and can_fire:
		shoot()
		can_fire = false
		await get_tree().create_timer(fire_cooldown).timeout
		can_fire = true

func shoot():
	if laser_scene == null:
		return
	
	var laser = laser_scene.instantiate()
	laser.global_position = global_position + fire_offset
	get_tree().current_scene.add_child(laser)
	
	# Add movement to the laser
	var move_tween = create_tween()
	move_tween.tween_property(laser, "position:y", 
							laser.position.y - 1000,  # Move up 1000 pixels
							2.0)  # Duration in seconds
	move_tween.tween_callback(laser.queue_free)
