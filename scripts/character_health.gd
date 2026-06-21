extends Node2D
class_name CharacterHealth

@export var max_health = 100
var health:float

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
	get_parent().queue_free()
