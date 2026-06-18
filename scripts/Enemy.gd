extends CharacterBody2D

@export var speed = 30;
@export var speed_rotation = 2;
@export var stopping_distance = 280;
@export var hovering_height = 65;

@export var fire_interval = 2
@onready var player = $"../Player";
var bullet_scene = preload("res://scenes/Bullet.tscn")
var can_shoot := true;


var angle = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		return
	var direction = (player.global_position - global_position).normalized()
	hover(delta,direction)
	if can_shoot:
		shoot(direction)

func hover(delta:float,direction:Vector2):
	#Ground is at 570
	var ground_distance = abs(global_position.y - 570)
	var target_angle = rad_to_deg(direction.angle())
	var distance = global_position.distance_to(player.global_position)
	var target_velocity = direction * speed
	
	if target_angle < 90:
		angle = deg_to_rad(45)
	elif target_angle > 90:
		angle = deg_to_rad(-45)
	
	if distance < stopping_distance:
		target_velocity = direction * 0
		angle = 0
	
	velocity = velocity.lerp(target_velocity, 0.1)

	if ground_distance < hovering_height:
		velocity.y = 0
	
	move_and_slide()
	rotation = lerp_angle(rotation,angle,speed_rotation*delta)

func shoot(direction):
	can_shoot = false;
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position
	   
	bullet.direction = direction;
	await get_tree().create_timer(fire_interval*randf()).timeout
	can_shoot = true       

	
