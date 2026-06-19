extends Area2D

var speed = 800.0
var direction = Vector2.RIGHT

func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body):
	queue_free()
