extends KinematicBody2D
class_name EnemyMain

onready var sprite: Sprite = get_node("Texture")
onready var physic_collision: CollisionShape2D = get_node("Collision")

onready var hitbox: Area2D = get_node("HitBox")
onready var in_range: Area2D = get_node("InRange")
onready var detection_area: Area2D = get_node("DetectionArea")

onready var collision_data: Dictionary = {
	self: physic_collision,
	hitbox: hitbox.get_node("Collision"),
	in_range: in_range.get_node("Collision"),
	detection_area: detection_area.get_node("Collision")
}

var velocity: Vector2 = Vector2.ZERO

var hurt: bool = false
var death: bool = false
var attack: bool = false

export(String) var group_name
export(int) var distance_threshold
export(Vector2) var collision_offset

func _physics_process(_delta: float) -> void:
	move()
	velocity = move_and_slide(velocity)
	sprite.animate(velocity)
	
	
func move() -> void:
	var target: KinematicBody2D = detection_area.target_body
	if is_instance_valid(target) and target != null:
		var distance: Vector2 = target.global_position - global_position
		var direction = distance.normalized()
		velocity = direction * 90
		
		if distance.length() < distance_threshold:
			attack = true
			
	else:
		velocity = Vector2.ZERO
		
		
func update_collision_list_position(x_position: int) -> void:
	for key in collision_data.keys():
		if key == self:
			collision_data[key].position.x = collision_offset.x * x_position
		else:
			key.position.x = collision_offset.x * x_position
