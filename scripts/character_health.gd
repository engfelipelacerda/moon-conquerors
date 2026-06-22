extends Node2D
class_name CharacterHealth

signal died

@export var max_health = 100
var health:float
@export var is_player := false

func _ready() -> void:
	health = max_health

func damage(hit_value:float):
	health -= hit_value
	print("Vida: ", health, " / ", max_health)
	if(health <= 0):
		die()

func die():
	if is_player:
		var game_over = preload("res://scenes/GameOver.tscn").instantiate()
		get_tree().current_scene.add_child(game_over)
		get_tree().paused = true
	else:
		died.emit()
		get_parent().queue_free()
