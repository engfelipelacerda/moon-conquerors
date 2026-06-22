extends Node2D

@onready var spawner = $lm_enemy_spawn

var wave_number := 0
var enemies_alive := 0
var enemies_remaining_to_spawn := 0

var upgrade_pool = [
	{"id": "damage", "label": "Dano +20%"},
	{"id": "speed", "label": "Velocidade +15%"},
	{"id": "fire_rate", "label": "Cadência de tiro +15%"},
	{"id": "max_health", "label": "Vida máxima +20%"},
]

func _ready() -> void:
	spawner.enemy_spawned.connect(_on_enemy_spawned)
	start_wave()

func start_wave():
	wave_number += 1
	enemies_alive = 0
	var amount = calculate_enemy_count(wave_number)
	enemies_remaining_to_spawn = amount
	var config = build_enemy_config(wave_number)
	var interval = get_spawn_interval(wave_number)
	spawner.spawn_wave(amount, config, interval)

func calculate_enemy_count(wave:int) -> int:
	return 5 + wave * 2

func get_spawn_interval(wave:int) -> float:
	return max(0.3, 1.2 - wave * 0.05)

func build_enemy_config(wave:int) -> EnemyConfig:
	var config = EnemyConfig.new()
	config.speed = 80 + wave * 5
	config.speed_rotation = 2
	config.stopping_distance = 180
	config.hovering_height = 150
	config.fire_interval = max(0.5, 2.0 - wave * 0.1)
	config.enemy_damage = 2 + wave
	return config

func _on_enemy_spawned(enemy):
	enemies_alive += 1
	enemies_remaining_to_spawn -= 1
	enemy.enemy_health.died.connect(_on_enemy_died)

func _on_enemy_died():
	enemies_alive -= 1
	if enemies_alive <= 0 and enemies_remaining_to_spawn <= 0:
		call_deferred("show_upgrade_screen")

func show_upgrade_screen():
	var options = upgrade_pool.duplicate()
	options.shuffle()
	options = options.slice(0, 3)

	var upgrade_screen = preload("res://scenes/UpgradeScreen.tscn").instantiate()
	get_tree().current_scene.add_child(upgrade_screen)
	get_tree().paused = true
	upgrade_screen.show_options(options)
	upgrade_screen.upgrade_chosen.connect(_on_upgrade_chosen)

func _on_upgrade_chosen(upgrade_id: String):
	apply_upgrade(upgrade_id)
	get_tree().paused = false
	start_wave()

func apply_upgrade(id: String):
	match id:
		"damage":
			Game.player.bullet_damage *= 1.2
		"speed":
			Game.player.speed *= 1.15
		"fire_rate":
			Game.player.fire_rate *= 0.85
		"max_health":
			Game.player.health.max_health *= 1.2
			Game.player.health.health = Game.player.health.max_health
