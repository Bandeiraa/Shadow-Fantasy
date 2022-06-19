extends Area2D
class_name HitBox

var health

export(NodePath) onready var stats = get_node(stats) as Node
export(NodePath) onready var parent = get_node(parent) as KinematicBody2D

export(int, 10, 60, 5) var collision_radius = 10

func _ready() -> void:
	health = stats.health
	
	
func update_health(area) -> void:
	#health -= area.damage
	if health <= 0:
		parent.death = true
		return
		
	#parent.hurt = true
	#Knockback
