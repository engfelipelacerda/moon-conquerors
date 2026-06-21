extends Node2D
class_name EnemyMovement

var player:CharacterBody2D = null;
var ground_raycast:RayCast2D = null;
var floor_repelling_force:Vector2 = Vector2.ZERO;
var steering_force = Vector2.ZERO


var MAX_RANGE_GROUND_RAYCAST = 900
var DEFAULT_STOPPING_DISTANCE = 300
var DEFAULT_SEPARATION_STRENGTH = 2.2
var DEFAULT_HOVERING_HEIGHT = 50

#=====DEBUG=======
var debug_floor_repelling_force:Vector2 = Vector2.ZERO
var debug_player_force:Vector2 = Vector2.ZERO
var debug_separation_force:Vector2 = Vector2.ZERO

@export var stopping_distance:float = DEFAULT_STOPPING_DISTANCE
@export var separation_force_strength = DEFAULT_SEPARATION_STRENGTH
@export var hovering_height = DEFAULT_HOVERING_HEIGHT

func _ready() -> void:
	player = Game.player
	ground_raycast = $"../RayCast2D";
	ground_raycast.target_position = Vector2(0,MAX_RANGE_GROUND_RAYCAST)

func move_vector() -> Vector2:
	steering_force = Vector2.ZERO
	var enemy_to_player = (global_position - player.global_position)
	
	var player_force = Vector2.ZERO
	if enemy_to_player.length() > stopping_distance+100:
		player_force = -enemy_to_player.normalized()
	elif enemy_to_player.length() < stopping_distance:
		player_force = enemy_to_player.normalized()
	else:
		player_force = Vector2.ZERO
	
	#Boids System
	var separation_force:Vector2 = Vector2.ZERO
	for neighbor:CharacterBody2D in get_all_neighbors():
		var enemy_to_neighbor = global_position - neighbor.global_position
		var neighbor_distance = enemy_to_neighbor.length()
		var neighbor_direction = enemy_to_neighbor.normalized()
		
		var strength = (stopping_distance - neighbor_distance)/ stopping_distance
		
		if neighbor_distance < stopping_distance:
			separation_force+=neighbor_direction*strength;
		elif neighbor_distance > (stopping_distance + 50):
			separation_force = Vector2.ZERO
	
	steering_force+=separation_force.normalized()
	
	#Minimum Hovering height
	var ground_distance = get_ground_distance()
	if ground_distance < hovering_height:
		floor_repelling_force = Vector2.UP
	elif ground_distance > (hovering_height + 180):
		floor_repelling_force = Vector2.DOWN
	
	steering_force = (
		player_force
		+floor_repelling_force*0.8
		+separation_force * 0.5
		).normalized()
		
	debug_floor_repelling_force = floor_repelling_force
	debug_player_force = player_force
	debug_separation_force = separation_force

	queue_redraw()
	return steering_force
	
func get_all_neighbors() -> Array:
	var neighbors = get_tree().get_nodes_in_group("lm_enemies")
	neighbors.erase(self)
	return neighbors

func get_ground_distance() -> float:
	#var ground_distance = ground_raycast.get_collision_point().distance_to(global_position)
	var ground_distance = abs(global_position.y - 300)
	return ground_distance

func hover_angle(steering_force:Vector2) -> float:
	return deg_to_rad(25.0 * steering_force.x)
	
func _draw() -> void:
	return 
	draw_line(
		Vector2.ZERO,
		debug_floor_repelling_force*50,
		Color.GREEN,
		2)
	draw_line(
		Vector2.ZERO,
		debug_player_force*50,
		Color.RED,
		2)
	draw_line(
		Vector2.ZERO,
		debug_separation_force*50,
		Color.BLUE,
		2)
