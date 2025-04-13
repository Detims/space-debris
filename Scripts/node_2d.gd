extends Node2D

@export var debris_scene: PackedScene
@export var initial_spawn_delay: float = 2.0
@export var min_spawn_delay: float = 0.2
@export var spawn_acceleration: float = 0.01

@onready var spawn_points := get_spawn_markers()

var spawn_timer := 0.0
var current_spawn_delay := initial_spawn_delay
var time_elapsed := 0.0

func get_spawn_markers() -> Array[Marker2D]:
	var markers: Array[Marker2D] = []
	for child in $DebrisSpawnPoints.get_children():
		if child is Marker2D:
			markers.append(child)
	return markers

func _ready():
	if spawn_points.is_empty():
		push_error("No Marker2D nodes found under DebrisSpawnPoints!")

func _process(delta: float) -> void:
	time_elapsed += delta
	spawn_timer -= delta

	if spawn_timer <= 0.0:
		spawn_debris()
		current_spawn_delay = max(min_spawn_delay, initial_spawn_delay - (spawn_acceleration * time_elapsed))
		spawn_timer = current_spawn_delay

func spawn_debris() -> void:
	if debris_scene == null or spawn_points.is_empty():
		return

	var spawn_point = spawn_points.pick_random()
	var debris = debris_scene.instantiate()
	debris.global_position = spawn_point.global_position
	add_child(debris)
