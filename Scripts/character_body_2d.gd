extends CharacterBody2D

var direction = Vector2.ZERO
const SPEED = 600.0
const JUMP_VELOCITY = -400.0
const MARGIN = 16.0  # Padding from screen edge

# Get references
@onready var collision_shape = $CollisionShape2D
@onready var camera = get_viewport().get_camera_2d()
@onready var viewport_rect = get_viewport().get_visible_rect()

var screen_left_bound: float
var screen_right_bound: float

func _ready():
	if camera == null:
		push_error("No camera found!")
		return
	
	# Calculate player's half-width (for boundary checking)
	var player_half_width = collision_shape.shape.get_rect().size.x / 2
	
	# Calculate screen bounds in world coordinates
	var camera_center = camera.global_position
	var viewport_half_width = viewport_rect.size.x / (2 * camera.zoom.x)
	
	screen_left_bound = camera_center.x - viewport_half_width + player_half_width + MARGIN - 600
	screen_right_bound = camera_center.x + viewport_half_width - player_half_width - MARGIN - 510

func _physics_process(delta):
	if camera == null:
		return
	
	# Handle horizontal movement
	var input = Input.get_axis("ui_left", "ui_right")
	direction.x = input
	
	# Apply movement using velocity (proper for CharacterBody2D)
	velocity.x = direction.x * SPEED
	
	# Calculate proposed movement
	var proposed_position = position + velocity * delta
	
	# Constrain to camera bounds
	proposed_position.x = clamp(proposed_position.x, screen_left_bound, screen_right_bound)
	
	# Move the character
	position = proposed_position
