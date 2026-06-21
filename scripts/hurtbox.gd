extends Area2D

class_name Hurtbox

@export var faction:Factions.Type
@onready var health = $"../health"

func receive_hit(damage:float):
	health.damage(damage)
