extends Area2D
class_name InRange

onready var collision: CollisionShape2D = get_node("Collision")

var bodies: Array

export(int, 60, 600, 60) var collision_radius = 60

func _ready() -> void:
	define_collision_radius()
	
	
func define_collision_radius() -> void:
	var collision_shape: Shape2D = collision.get_shape()
	collision_shape.set_radius(collision_radius)
	
	
func body_in_range_entered(body) -> void:
	bodies.append(body)
	
	
func body_in_range_exited(body) -> void:
	var body_index: int = bodies.find(body)
	bodies.remove(body_index)
