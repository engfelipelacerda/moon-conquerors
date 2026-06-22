extends CharacterBody2D
# Configurações de movimentação
@export var speed = 80
@export var speed_rotation = 2
@export var stopping_distance = 180
@export var hovering_height = 150
# Configurações de ataque
@export var fire_interval = 2
@export var enemy_damage = 30
@export var shooting_distance = 500
var bullet_scene = preload("res://entities/EnemyBullet.tscn")
@onready var animation = $AnimatedSprite2D
var can_shoot := true
var angle = 0
var is_dying := false
# Estratégia de movimentação do inimigo
@export var enemy_movement: EnemyMovement
# Saúde do inimigo
@onready var enemy_health: CharacterHealth = $health

func setup(config:EnemyConfig):
	speed = config.speed;
	speed_rotation = config.speed_rotation;
	stopping_distance = config.stopping_distance;
	hovering_height = config.hovering_height;
	fire_interval = config.fire_interval
	enemy_damage = config.enemy_damage
	enemy_health.max_health = config.enemy_health_amount
	enemy_health.health = config.enemy_health_amount

func _ready() -> void:
	# Adiciona o inimigo ao grupo de inimigos
	add_to_group("lm_enemies")
	enemy_health.died.connect(_on_died)

func _physics_process(delta: float) -> void:
	if is_dying:
		return

	if Game.player == null:
		return
	
	# Toca a animação
	animation.play("flying")
	
	# Calcula a direção desejada de movimento
	var steering_force = enemy_movement.move_vector()
	var movement = steering_force * speed
	# Suaviza a movimentação
	velocity = velocity.lerp(movement, 0.8)
	# Rotaciona o inimigo na direção do movimento
	var angle = enemy_movement.hover_angle(steering_force)
	rotation = lerp_angle(rotation, angle, speed_rotation * delta)
	move_and_slide()
	if can_shoot and Game.player.global_position.distance_to(global_position) < shooting_distance :
		shoot(Game.player)
	
func shoot(target):
	var direction = (target.global_position - global_position).normalized()
	# Impede disparos contínuos
	can_shoot = false
	# Cria e posiciona o projétil
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_parent().add_child(bullet)
	# Configura bala
	var config = BulletConfig.new()
	config.faction_owner = Factions.Type.ENEMY
	config.damage = enemy_damage
	bullet.setup(config)
	
	# Define a direção do disparo
	bullet.direction = direction
	# Aguarda o tempo de recarga antes de permitir outro tiro
	await get_tree().create_timer(fire_interval * randf()).timeout
	can_shoot = true

func _on_died():
	is_dying = true
	can_shoot = false
	velocity = Vector2.ZERO
	animation.play("kill")
	await animation.animation_finished
	queue_free()
