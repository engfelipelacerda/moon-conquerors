extends Node
class_name EnemyConfig

var enemy_health_amount: float = 100
var speed = 80;
var speed_rotation = 2;
var stopping_distance = 180;
var hovering_height = 150;
var fire_interval = 2
var enemy_damage = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
