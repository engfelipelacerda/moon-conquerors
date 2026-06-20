extends Node2D

@export var max_amount_enemies:int = 5
@export var min_x_position:float = 0
@export var max_x_position:float = 1153.0

var lm_enemy = preload("res://scenes/Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var lm_enemies = get_tree().get_nodes_in_group("lm_enemies")
	
	if lm_enemies.size() < 5:
		spawn_enemy()
		
func spawn_enemy():
	var enemy = lm_enemy.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = get_random_spawn_point()
	

func get_random_spawn_point() -> Vector2:
	var point = Vector2.ZERO
	point.y = global_position.y
	point.x = min_x_position + (max_x_position-min_x_position)*randf()
	return point
