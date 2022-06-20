extends Sprite
class_name WarriorTexture

export(NodePath) onready var parent = get_node(parent) as KinematicBody2D
export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

func animate(velocity: Vector2) -> void:
	verify_direction(velocity.x)
	if parent.attack or parent.hurt or parent.death:
		action_behavior()
	else:
		move_behavior(velocity)
		
		
func verify_direction(direction: float) -> void:
	if direction > 0:
		flip_h = false
	elif direction < 0:
		flip_h = true
		
		
func action_behavior() -> void:
	if parent.death:
		pass
		
	elif parent.hurt:
		pass
		
	elif parent.attack:
		animation.play(parent.attack_list[parent.attack_index])
		
		
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		animation.play("run")
	else:
		animation.play("idle")
		
		
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "swing_1" or anim_name == "swing_2":
		parent.attack = false
		parent.attack_index += 1
		parent.set_physics_process(true)
