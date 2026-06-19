extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const GRAVITY = 1200.0
const FIRE_RATE = 0.15

var bullet_scene = preload("res://scenes/Bullet.tscn")
var fire_timer = 0.0

func _physics_process(delta):
	# Gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimento horizontal
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	else:
		velocity.x = 0

	move_and_slide()

	# Atira automaticamente
	fire_timer -= delta
	if fire_timer <= 0.0:
		fire_timer = FIRE_RATE
		shoot()

func _input(event: InputEvent) -> void:
	pass

func shoot():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position

	# Direção para o mouse
	var mouse_pos = get_global_mouse_position()
	bullet.direction = (mouse_pos - global_position).normalized()
	bullet.rotation = bullet.direction.angle()
