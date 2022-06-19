extends KinematicBody2D
class_name EnemyMain

onready var sprite: Sprite = get_node("Texture")

onready var hitbox: Area2D = get_node("HitBox")
onready var in_range: Area2D = get_node("InRange")
onready var detection_area: Area2D = get_node("DetectionArea")

onready var areas_list: Array = [
	hitbox,
	in_range,
	detection_area
]

var velocity: Vector2 = Vector2.ZERO

var hurt: bool = false
var death: bool = false
var attack: bool = false

export(int) var distance_threshold
export(Vector2) var collision_offset

func _ready() -> void:
	configure_collision()
	
	
func configure_collision() -> void:
	var collision: CollisionShape2D = get_node("Collision")
	var shape: Shape2D = collision.get_shape()
	shape.set_radius(hitbox.collision_radius)
	collision.position = collision_offset
	
	for area in areas_list:
		var collision_shape: Shape2D = area.get_child(0).get_shape()
		collision_shape.set_radius(area.collision_radius)
		area.position = collision_offset
		
		
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
