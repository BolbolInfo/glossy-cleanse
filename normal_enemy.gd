extends CharacterBody2D

var is_angry = false
var can_shoot = true
var hp=100
@onready var pointer = $pointer
@onready var player_controller = %PlayerController
@onready var bubble_scene = preload("res://EnemyBubble.tscn")
@onready var enem_prog_bar = $enem_prog_bar
@onready var game_manager = %GameManager

func _ready():
	enem_prog_bar.max_value = hp
	enem_prog_bar.value = hp



func _process(delta):
	pointer.target_position.x = player_controller.global_position.x-global_position.x
	pointer.target_position.y = player_controller.global_position.y-global_position.y
	
	if is_angry and can_shoot:
		shoot()

func shoot():
	can_shoot = false
	var bubble = bubble_scene.instantiate()
	bubble.global_position = global_position
	var direction = pointer.target_position.normalized()
	bubble.direction = direction

	get_parent().add_child(bubble)
	await get_tree().create_timer(1.2).timeout
	can_shoot=true
	

func _on_detector_body_entered(body):
	if body.is_in_group("player"):
		is_angry = true


func _on_cooldown_timeout():
	can_shoot=true
	
	
func take_damage (amount):
	hp -= amount
	udate_enem_hpbar()
	if hp <= 0:
		game_manager.decrease_normal_enemy_count()
		queue_free()

func udate_enem_hpbar():
	enem_prog_bar.value = hp
