extends CharacterBody2D
@export var move_speed: float = 50.0
@export var move_direction: int = [1, -1].pick_random()  # 1 for right, -1 for left
@export var move_down_amount: float = 3.0
@export var boundary_left: float = 0
@export var boundary_right: float = 1024

@onready var animated_sprite = $AnimatedSprite2D

var available_animations = ["apple","banana","battery","bottle","sattellite","shaq","stud", "thruster", "trash", "curry", "ball", "turt"]

func _ready():
	animated_sprite.play(available_animations.pick_random())
	
func _physics_process(delta: float) -> void:
	# Horizontal movement
	# var velocity = Vector2(move_speed * move_direction, 0)
	
	# Move manually instead of using velocity
	position.x += move_speed * move_direction * delta
	position.y += move_down_amount

	# Reverse direction if reaching screen edge
	if position.x <= boundary_left or position.x >= boundary_right:
		move_direction *= -1
	
	if not animated_sprite.is_playing():
		animated_sprite.play(available_animations.pick_random())
	
	if Globals.PlayerisAlive == false:
		print("died")
		queue_free()
	
	move_and_slide()
