extends KinematicBody2D
class_name EnemyMain

onready var stats: Node = get_node("Stats")
onready var sprite: Sprite = get_node("Texture")

onready var detection_area: Area2D = get_node("DetectionArea")

var velocity: Vector2 = Vector2.ZERO

var hurt: bool = false
var death: bool = false
var attack: bool = false

export(String) var group_name
export(int) var distance_threshold
export(Vector2) var collision_offset

func _physics_process(_delta: float) -> void:
	var target: KinematicBody2D = detection_area.target_body
	if is_instance_valid(target) and not (attack or hurt or death):
		move(get_direction(target), get_distance(target))
	else:
		velocity = Vector2.ZERO
		
	velocity = move_and_slide(velocity)
	sprite.animate(velocity)
	
	
func move(direction: Vector2, distance: float) -> void:
	velocity = direction * stats.speed
	if distance < distance_threshold:
		attack = true
		velocity = Vector2.ZERO
		
		
func get_direction(target: KinematicBody2D) -> Vector2:
	return (target.global_position - global_position).normalized()
	
	
func get_distance(target: KinematicBody2D) -> float:
	return (target.global_position - global_position).length()
	
	
func special_direction_verifier() -> void:
	var target: KinematicBody2D = detection_area.target_body
	sprite.verify_direction(get_direction(target).x)
