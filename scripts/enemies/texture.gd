extends Sprite
class_name EnemyTexture

var textures_list: Array = []

export(NodePath) onready var parent = get_node(parent) as KinematicBody2D
export(NodePath) onready var file_manager = get_node(file_manager) as Node
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

func _ready() -> void:
	textures_list = file_manager.get_files_in_path()
