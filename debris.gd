extends CharacterBody2D

@export var move_speed: float = 50.0
@export var move_direction: int = 1  # 1 for right, -1 for left
@export var move_down_amount: float = 10.0
@export var boundary_left: float = 0
@export var boundary_right: float = 1024

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var hit_detection_area = $HitDetectionArea

var available_animations = ["stud", "thruster", "trash", "curry", "ball"]
var is_alive = true

func _ready():
	animated_sprite.play(available_animations.pick_random())
	# Connect area_entered signal if using Area2D for detection
	if hit_detection_area:
		hit_detection_area.area_entered.connect(_on_area_entered)
	
func _physics_process(delta: float) -> void:
	if not is_alive:
		return
	
	# Horizontal movement
	position.x += move_speed * move_direction * delta

	# Reverse direction if reaching screen edge
	if position.x <= boundary_left or position.x >= boundary_right:
		move_direction *= -1
		position.y += move_down_amount
	
	if not animated_sprite.is_playing():
		animated_sprite.play(available_animations.pick_random())

func _on_area_entered(area):
	# Check if the entering area is a laser
	if area.is_in_group("lasers"):
		destroy()

func destroy():
	if not is_alive:
		return
	
	is_alive = false
	# Disable collisions
	collision_shape.set_deferred("disabled", true)
	if hit_detection_area:
		hit_detection_area.monitoring = false
	
	# Play destruction effects
	animated_sprite.play("explode")  # Add this animation to your sprite
	await animated_sprite.animation_finished
	
	queue_free()
