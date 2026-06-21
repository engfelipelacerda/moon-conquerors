extends CharacterBody2D

@export var speed = 80;
@export var speed_rotation = 2;
@export var stopping_distance = 180;
@export var hovering_height = 150;
@export var fire_interval = 2
@export var enemy_damage = 30

var bullet_scene = preload("res://scenes/Bullet.tscn")

var can_shoot := true;
var angle = 0;

@export var enemy_movement:EnemyMovement
@export var enemy_health:CharacterHealth

func setup(config:EnemyConfig):
	speed = config.speed;
	speed_rotation = config.speed_rotation;
	stopping_distance = config.stopping_distance;
	hovering_height = config.hovering_height;
	fire_interval = config.fire_interval
	enemy_damage = config.enemy_damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("lm_enemies")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Game.player == null:
		return
		
	var steering_force = enemy_movement.move_vector()
	var movement = steering_force* speed
	velocity = velocity.lerp(movement, 0.8)
	
	var angle = enemy_movement.hover_angle(steering_force)
	rotation = lerp_angle(rotation,angle,speed_rotation*delta)
	
	move_and_slide()
	if can_shoot:
		shoot(Game.player)
	
func shoot(target):
	var direction = (target.global_position - global_position).normalized()
	can_shoot = false;
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	get_parent().add_child(bullet)
	
	var config = BulletConfig.new()
	config.faction_owner = Faction.Type.ENEMY
	config.damage = enemy_damage
	bullet.setup(config)
	   
	bullet.direction = direction;
	await get_tree().create_timer(fire_interval*randf()).timeout
	can_shoot = true       
