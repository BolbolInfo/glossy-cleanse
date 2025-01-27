extends RayCast2D

@onready var bubble_scene = preload("res://EnemyBubble.tscn")  
@onready var main = get_tree().get_root().get_node("lvl")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
