extends Node

var hover_enemy_count = 0
var normal_enemy_count = 1
var game_over = false

@export var game_over_scene = preload("res://level_complete.tscn")  # Path to your game over screen

func _process(delta):
	if hover_enemy_count <= 0 and normal_enemy_count <= 0 and not game_over:
		game_over = true
		show_game_over_screen()

func decrease_hover_enemy_count():
	hover_enemy_count -= 1

func decrease_normal_enemy_count():
	normal_enemy_count -= 1

func show_game_over_screen():
	# Load and instance the game over scene
	var game_over_instance = game_over_scene.instantiate()
	get_tree().get_root().add_child(game_over_instance)
