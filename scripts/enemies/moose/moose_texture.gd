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
		animation.play("attack")
		texture = load(textures_list[states.ATTACK])
		
		
func move_behavior(velocity: Vector2) -> void:
	if velocity != Vector2.ZERO:
		animation.play("run")
		texture = load(textures_list[states.RUN])
	else:
		animation.play("idle")
		texture = load(textures_list[states.IDLE])
