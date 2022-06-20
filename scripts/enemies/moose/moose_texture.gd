extends EnemyTexture
class_name MooseTexture

enum states {
	ATTACK,
	DEATH,
	HURT,
	IDLE,
	RUN
}

func animate(velocity: Vector2) -> void:
	verify_direction(velocity.x)
	if parent.attack or parent.hurt or parent.death:
		action_behavior()
	else:
		move_behavior(velocity)
		
		
func action_behavior() -> void:
	if parent.death:
		animation.play("death")
		texture = load(textures_list[states.DEATH])
		
	elif parent.hurt:
		animation.play("hurt")
		texture = load(textures_list[states.HURT])
		
	elif parent.attack:
		animation.play("attack" + attack_suffix)
		texture = load(textures_list[states.ATTACK])
		
		
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		animation.play("run")
		texture = load(textures_list[states.RUN])
	else:
		animation.play("idle")
		texture = load(textures_list[states.IDLE])
		
		
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"attack_left":
			parent.attack = false
			
		"attack_right":
			parent.attack = false
			
		"hurt":
			parent.hurt = false
			parent.set_physics_process(true)
			
		"death":
			print("Death")
