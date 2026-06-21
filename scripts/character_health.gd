extends Node2D
class_name CharacterHealth

@export var max_health = 100
var health:float
@export var is_player := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damage(hit_value:float):
	health -= hit_value
	print(health)
	if(health <= 0):
		die()
	

func die():
	if is_player:
		var game_over = preload("res://scenes/GameOver.tscn").instantiate()
		get_tree().current_scene.add_child(game_over)
		get_tree().paused = true
	else:
		get_parent().queue_free()
