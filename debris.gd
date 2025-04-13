extends CharacterBody2D
@export var move_speed: float = 50.0
@export var move_direction: int = 1  # 1 for right, -1 for left
@export var move_down_amount: float = 10.0
@export var boundary_left: float = 0
@export var boundary_right: float = 1024

@onready var animated_sprite = $AnimatedSprite2D

var available_animations = ["stud", "thruster", "trash", "curry", "ball"]

func _ready():
	animated_sprite.play(available_animations.pick_random())
	
func _physics_process(delta: float) -> void:
	# Horizontal movement
	var velocity = Vector2(move_speed * move_direction, 0)
	move_and_slide()

	# Move manually instead of using velocity
	position.x += move_speed * move_direction * delta

	# Reverse direction if reaching screen edge
	if position.x <= boundary_left or position.x >= boundary_right:
		move_direction *= -1
		position.y += move_down_amount
	
	if not animated_sprite.is_playing():
		animated_sprite.play(available_animations.pick_random())
