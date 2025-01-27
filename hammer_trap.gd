extends StaticBody2D

@export var speed_up: float = 200.0 # Speed of hammer rising
@export var speed_down: float = 200.0 # Speed of hammer falling
@export var delay_time: float = 2.0 # Delay time before next movement (can be randomized)

@onready var collision_shape = $CollisionShape2D
@onready var timer = $Timer

var is_going_up = true
var timer_started = false

func _ready():
	# Start the timer to control the movement
	timer.start(delay_time)

func _process(delta):
	if is_going_up:
		move_hammer_up(delta)
	else:
		move_hammer_down(delta)

	if timer.time_left == 0 and not timer_started:
		# Start the upward movement after the delay
		timer_started = true
		is_going_up = true

func move_hammer_up(delta):
	position.y -= speed_up * delta
	if position.y <= 0: # Adjust based on your hammer's resting position
		# Hammer reaches the top
		is_going_up = false
		timer_started = false
		timer.start(delay_time) # Restart the timer before going down

func move_hammer_down(delta):
	position.y += speed_down * delta
	if position.y >= 200: # Adjust based on your hammer's maximum down position
		# Hammer reaches the bottom, stop falling
		is_going_up = true
		timer_started = false
		timer.start(delay_time) # Restart the timer before going up
func _on_Hammer_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(50) # Adjust damage based on your needs
