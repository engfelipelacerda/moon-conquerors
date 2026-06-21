extends Area2D

@onready var graphics:ColorRect = $ColorRect

var speed = 800.0
var direction = Vector2.RIGHT

var faction_owner:Faction.Type
var damage:float
var color:Color

func setup(config:BulletConfig):
	damage = config.damage
	faction_owner = config.faction_owner

func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass

func _on_body_entered(body):
	queue_free()
	pass # Replace with function body.

func _on_area_entered(area:Area2D):
	if area is Hurtbox:
		if area.faction != faction_owner:
			area.receive_hit(damage)
		
