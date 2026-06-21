extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Constantes de movimentação e combate
const SPEED = 300.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 1200.0
const FIRE_RATE = 0.15

# Ponto de origem dos disparos
@onready var muzzle = $Muzzle

# Cena do projétil e controle de cadência de tiro
var bullet_scene = preload("res://entities/Bullet.tscn")
var fire_timer = 0.0

func _ready():
	# Registra este objeto como o jogador global do jogo
	Game.player = self

func _physics_process(delta):
	# Aplica gravidade enquanto o jogador estiver no ar
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Executa o pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Controla o movimento horizontal
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction > 0: 
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.play("alien_walk")
		elif direction < 0:
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.play("alien_walk")
		else:
			animated_sprite_2d.play("alien_idle")
	else:
		animated_sprite_2d.play("alien_jump")

	move_and_slide()

	# Disparo automático com intervalo definido
	fire_timer -= delta
	if fire_timer <= 0.0:
		fire_timer = FIRE_RATE
		shoot()

func _input(event: InputEvent) -> void:
	pass

func shoot():
	# Instancia e posiciona o projétil
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)


	# Configuração da bala	
	var config = BulletConfig.new()
	config.damage = 35
	config.faction_owner = Factions.Type.PLAYER
	bullet.setup(config)
	
	var mouse_pos = get_global_mouse_position()
	bullet.global_position = muzzle.global_position

	# Define direção e rotação do projétil em relação ao mouse
	var dir = (mouse_pos - muzzle.global_position).normalized()
	bullet.direction = dir
	bullet.rotation = dir.angle()
