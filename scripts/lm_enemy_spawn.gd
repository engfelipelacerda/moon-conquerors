extends Node2D

signal enemy_spawned(enemy)

@export var min_x_position:float = 0
@export var max_x_position:float = 1153.0

var lm_enemy = preload("res://entities/Enemy.tscn")

func spawn_wave(amount:int, config:EnemyConfig, interval:float) -> void:
	for i in amount:
		spawn_enemy(config)
		await get_tree().create_timer(interval).timeout

func spawn_enemy(config:EnemyConfig):
	var enemy = lm_enemy.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = get_random_spawn_point()
	enemy.setup(config)
	enemy_spawned.emit(enemy)

func get_random_spawn_point() -> Vector2:
	var point = Vector2.ZERO
	point.y = global_position.y
	point.x = min_x_position + (max_x_position-min_x_position)*randf()
	return point
