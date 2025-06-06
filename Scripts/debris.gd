extends CharacterBody2D
@export var move_speed: float = 50.0
@export var move_direction: int = [1, -1].pick_random()  # 1 for right, -1 for left
@export var move_down_amount: float = 3.0
@export var boundary_left: float = 0
@export var boundary_right: float = 1024
@export var debris_alive = true

@onready var animated_sprite = $AnimatedSprite2D

var available_animations = ["apple","banana","battery","bottle","sattellite","shaq","stud", "thruster", "trash", "curry", "ball", "turt"]

func _ready():
	var type = available_animations.pick_random()
	if type == "curry":
		Globals.CurryDebrisDestroyed = true
	if type == "ball":
		Globals.BallDebrisDestroyed = true
	if type == "thruster":
		Globals.RocketDebrisDestroyed = true
	if type == "stud":
		Globals.StudDebrisDestroyed = true
	if type == "sattellite":
		Globals.SatelliteisDestroyed = true
	if type == "apple":
		Globals.AppleisDestroyed = true
	if type == "banana":
		Globals.BananaisDestroyed = true
	if type == "shaq":
		Globals.ShaqisDestroyed = true
	if type == "bottle":
		Globals.BottleisDestroyed = true
	if type == "turt":
		Globals.TurtisDestroyed = true
	if type == "trash":
		Globals.TrashisDestroyed = true
	if type == "battery":
		Globals.BatteryisDestroyed = true
	animated_sprite.play(type)
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Laser"):
		debris_alive = false
	
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
	
	if debris_alive == false:
		print("died")
		queue_free()
	
	move_and_slide()
