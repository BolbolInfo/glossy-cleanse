extends StaticBody2D

var hp=100
#var enem_count = 0
@onready var floating_enemy = preload("res://floating_enemy.tscn")
@onready var game_manager = %GameManager
@onready var enem_prog_bar = $enem_prog_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	enem_prog_bar.max_value = hp
	enem_prog_bar.value = hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func call_dec():
	game_manager.decrease_hover_enemy_count()


func spawn_enem():
	var offsets = [Vector2(30, 0), Vector2(-30, 0)]   # Define spawn offsets
	for offset in offsets:
		var enemy = floating_enemy.instantiate()
		enemy.global_position = global_position + offset
		get_parent().add_child(enemy)
		game_manager.hover_enemy_count += 1


func _on_cooldown_timeout():
	if game_manager.hover_enemy_count<2:
		spawn_enem()
		
		
		
func take_damage(amount):
	hp-=amount
	update_enem_hpbar()
	if hp<=0 : 
		queue_free()
	
func update_enem_hpbar():
	enem_prog_bar.value = hp
