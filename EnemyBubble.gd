extends CharacterBody2D

@export var speed: float   # Movement speed of the bubble.
@export var lifetime: float = 0.5  # Duration before the bubble disappears.

var direction = Vector2.ZERO  # Direction the bubble travels.

var rng = RandomNumberGenerator.new()

func _ready():
	# Start the bubble's lifetime timer.
	lifetime= rng.randf_range(0.2 ,0.5)
	$BubbleTimer.start(lifetime)
	speed = rng.randf_range(140,160)

func _physics_process(delta):
	# Move the bubble.
	position += direction * speed * delta

func _on_bubble_timer_timeout():
	# Remove the bubble after the timer ends.
	queue_free()



func _on_detector_body_entered(body):
	# Check if the bubble hit an enemy.
	if body.is_in_group("player"):
		body.take_damage(15)  # Apply damage to the enemy.
		queue_free()  # Destroy the bubble after hitting.
	elif  body.is_in_group("enemies") or body.is_in_group("Bubble") :
		pass
	else :
		queue_free()

