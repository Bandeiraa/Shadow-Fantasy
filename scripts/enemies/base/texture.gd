extends Sprite
class_name EnemyTexture

var textures_list: Array = []

export(float) var hitbox_x_position

export(NodePath) onready var hitbox = get_node(hitbox) as Area2D
export(NodePath) onready var parent = get_node(parent) as KinematicBody2D
export(NodePath) onready var file_manager = get_node(file_manager) as Node
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

func _ready() -> void:
	randomize()
	textures_list = file_manager.get_files_in_path()
	
	
func verify_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
		hitbox.position.x = -hitbox_x_position
		
	elif direction < 0:
		flip_h = true
		hitbox.position.x = hitbox_x_position
