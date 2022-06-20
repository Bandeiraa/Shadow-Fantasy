extends Stats
class_name EnemyStats

export(NodePath) onready var hurtbox = get_node(hurtbox) as Area2D

func _ready() -> void:
	hurtbox.damage = damage
