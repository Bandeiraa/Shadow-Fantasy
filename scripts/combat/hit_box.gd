extends Area2D
class_name HitBox

onready var collision: CollisionShape2D = get_node("Collision")

var health

export(NodePath) onready var stats = get_node(stats) as Node
export(NodePath) onready var parent = get_node(parent) as KinematicBody2D

export(int, 10, 60, 5) var collision_radius = 10

func _ready() -> void:
	randomize()
	health = stats.health
	define_collision_radius()
	
	
func define_collision_radius() -> void:
	var collision_shape: Shape2D = collision.get_shape()
	collision_shape.set_radius(collision_radius)
	
	
func update_health(area) -> void:
	if area.get_parent().group_name != parent.group_name and area is HurtBox:
		health -= area.damage
		if health <= 0:
			parent.death = true
			return
			
		parent.hurt = true
		#Knockback
