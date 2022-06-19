extends KinematicBody2D
class_name EnemyMain

onready var sprite: Sprite = get_node("Texture")

onready var in_range: Area2D = get_node("InRange")
onready var detection_area: Area2D = get_node("DetectionArea")

var velocity: Vector2 = Vector2.ZERO

var hurt: bool = false
var death: bool = false
var attack: bool = false

export(int) var distance_threshold

func _physics_process(_delta: float) -> void:
	move()
	velocity = move_and_slide(velocity)
	sprite.animate(velocity)
	
	
func move() -> void:
	var target: KinematicBody2D = detection_area.target_body
	if is_instance_valid(target):
		var distance: Vector2 = target.global_position - global_position
		var direction = distance.normalized()
		velocity = direction * 90
		
		if distance.length() < distance_threshold:
			attack = true
			
	else:
		velocity = Vector2.ZERO
