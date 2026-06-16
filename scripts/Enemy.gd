extends CharacterBody2D

@export var speed = 30;
@export var speed_rotation = 2;
@export var stopping_distance = 280;
@onready var player = $"../Player";
var angle = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player == null:
		return
	hover(delta)

func hover(delta:float):
	var direction = (player.global_position - global_position).normalized()
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
	move_and_slide()
	rotation = lerp_angle(rotation,angle,speed_rotation*delta)
	
	
