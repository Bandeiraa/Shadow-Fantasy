extends Area2D
class_name DetectionArea

onready var collision: CollisionShape2D = get_node("Collision")

var bodies: Array
var target_body: KinematicBody2D = null

export(bool) var change_seek_target = false
export(int, 60, 600, 60) var collision_radius = 60
export(NodePath) onready var parent = get_node(parent) as KinematicBody2D

func _ready() -> void:
	randomize()
	define_collision_radius()
	
	
func define_collision_radius() -> void:
	var collision_shape: Shape2D = collision.get_shape()
	collision_shape.set_radius(collision_radius)
	
	
func body_detection_entered(body) -> void:
	if body.group_name != parent.group_name:
		bodies.append(body)
		if bodies.size() == 1 or change_seek_target:
			target_body = body
			
			
func body_detection_exited(body):
	if not bodies.empty():
		var body_index: int = bodies.find(body)
		bodies.remove(body_index)
		
	if not bodies.empty():
		target_body = bodies[randi() % bodies.size()]
	else:
		target_body = null
