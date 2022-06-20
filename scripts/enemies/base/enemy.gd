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
	move()
	velocity = move_and_slide(velocity)
	sprite.animate(velocity)
	
	
func move() -> void:
	var target: KinematicBody2D = detection_area.target_body
	if is_instance_valid(target) and target != null:
		var distance: Vector2 = target.global_position - global_position
		var direction = distance.normalized()
		velocity = direction * stats.speed
		
		if distance.length() < distance_threshold:
			attack = true
			
	else:
		velocity = Vector2.ZERO
