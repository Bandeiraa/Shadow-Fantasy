extends Area2D
class_name HitBox

onready var collision: CollisionShape2D = get_node("Collision")

var health

export(NodePath) onready var stats = get_node(stats) as Node
export(NodePath) onready var parent = get_node(parent) as KinematicBody2D

export(int, 10, 60, 5) var collision_radius = 10
export(Vector2) var collision_offset

func _ready() -> void:
	health = stats.health
	define_collision_radius()
	
	
func define_collision_radius() -> void:
	var physic_collision: CollisionShape2D = parent.get_node("Collision")
	
	var collision_shape: Shape2D = collision.get_shape()
	var physic_collision_shape: Shape2D = physic_collision.get_shape()
	
	collision_shape.set_radius(collision_radius)
	physic_collision_shape.set_radius(collision_radius)
	
	collision.position = collision_offset
	physic_collision.position = collision_offset
	
	
func update_health(area) -> void:
	#health -= area.damage
	if health <= 0:
		parent.death = true
		return
		
	#parent.hurt = true
	#Knockback
