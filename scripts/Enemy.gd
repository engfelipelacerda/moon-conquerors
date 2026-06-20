extends CharacterBody2D

# Configurações de movimentação
@export var speed = 80
@export var speed_rotation = 2
@export var stopping_distance = 180
@export var hovering_height = 150

# Configurações de ataque
@export var fire_interval = 2
var bullet_scene = preload("res://entities/Bullet.tscn")
var can_shoot := true

var angle = 0

# Estratégia de movimentação do inimigo
@export var enemy_movement: EnemyMovement

func _ready() -> void:
	# Adiciona o inimigo ao grupo de inimigos
	add_to_group("lm_enemies")

func _physics_process(delta: float) -> void:
	# Calcula a direção desejada de movimento
	var steering_force = enemy_movement.move_vector()
	var movement = steering_force * speed

	# Suaviza a movimentação
	velocity = velocity.lerp(movement, 0.8)

	# Rotaciona o inimigo na direção do movimento
	var angle = enemy_movement.hover_angle(steering_force)
	rotation = lerp_angle(rotation, angle, speed_rotation * delta)

	move_and_slide()

	if can_shoot:
		pass

func shoot(direction):
	# Impede disparos contínuos
	can_shoot = false

	# Cria e posiciona o projétil
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position

	# Define a direção do disparo
	bullet.direction = direction

	# Aguarda o tempo de recarga antes de permitir outro tiro
	await get_tree().create_timer(fire_interval * randf()).timeout
	can_shoot = true
