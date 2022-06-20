extends Sprite
class_name WarriorTexture

export(NodePath) onready var stats = get_node(stats) as Node
export(NodePath) onready var hurtbox = get_node(hurtbox) as Area2D
export(NodePath) onready var parent = get_node(parent) as KinematicBody2D
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

var attack_suffix: String = "_right"

func animate(velocity: Vector2) -> void:
	verify_direction(velocity.x)
	if parent.attack or parent.hurt or parent.death:
		action_behavior()
	else:
		move_behavior(velocity)
		
		
func verify_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
		position.x = 2
		attack_suffix = "_right"
		
	elif direction < 0:
		flip_h = true
		position.x = -2
		attack_suffix = "_left"
		
		
func action_behavior() -> void:
	if parent.death:
		animation.play("death")
		
	elif parent.hurt:
		animation.play("hurt")
		
	elif parent.attack:
		var current_attack: String =  parent.attack_list[parent.attack_index]
		match current_attack:
			"swing_1":
				hurtbox.damage = stats.swing_1
				
			"swing_2":
				hurtbox.damage = stats.swing_2
				
		animation.play(current_attack + attack_suffix)
		
		
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		animation.play("run")
	else:
		animation.play("idle")
		
		
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "swing_1" + attack_suffix or anim_name == "swing_2" + attack_suffix:
		parent.attack = false
		parent.attack_index += 1
		parent.set_physics_process(true)
