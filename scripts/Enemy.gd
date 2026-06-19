extends CharacterBody2D

@export var speed = 80;
@export var speed_rotation = 2;
@export var stopping_distance = 180;
@export var hovering_height = 150;

@export var fire_interval = 2
var bullet_scene = preload("res://scenes/Bullet.tscn")
var can_shoot := true;

var angle = 0;

@export var enemy_movement:EnemyMovement
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("lm_enemies")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var steering_force = enemy_movement.move_vector()
	var movement = steering_force* speed
	velocity = velocity.lerp(movement, 0.8)
	
	var angle = enemy_movement.hover_angle(steering_force)
	rotation = lerp_angle(rotation,angle,speed_rotation*delta)
	
	move_and_slide()
	if can_shoot:
		pass
	
func shoot(direction):
	can_shoot = false;
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	   
	bullet.direction = direction;
	await get_tree().create_timer(fire_interval*randf()).timeout
	can_shoot = true       
