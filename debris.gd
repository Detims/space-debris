extends CharacterBody2D
@export var move_speed: float = 75.0
@export var move_direction: int = [1, -1].pick_random()  # 1 for right, -1 for left
@export var move_down_amount: float = 3.0
@export var boundary_left: float = 0
@export var boundary_right: float = 1024

@onready var animated_sprite = $AnimatedSprite2D

var available_animations = ["stud", "thruster", "trash", "curry", "ball"]

func _ready():
	animated_sprite.play(available_animations.pick_random())
	
func _physics_process(delta: float) -> void:
	# Horizontal movement
<<<<<<< Updated upstream
<<<<<<< Updated upstream
	# var velocity = Vector2(move_speed * move_direction, 0)
=======
	var velocity = Vector2(move_speed * move_direction, 0)
	move_and_slide()
>>>>>>> Stashed changes
=======
	var velocity = Vector2(move_speed * move_direction, 0)
	move_and_slide()
>>>>>>> Stashed changes

	# Move manually instead of using velocity
	position.x += move_speed * move_direction * delta
	position.y += move_down_amount

	# Reverse direction if reaching screen edge
	if position.x <= boundary_left or position.x >= boundary_right:
		move_direction *= -1
	
	if not animated_sprite.is_playing():
		animated_sprite.play(available_animations.pick_random())
<<<<<<< Updated upstream
<<<<<<< Updated upstream

	move_and_slide()
=======
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
