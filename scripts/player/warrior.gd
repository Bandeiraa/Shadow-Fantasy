extends KinematicBody2D
class_name Warrior

onready var sprite: Sprite = get_node("Texture")
onready var stats: Node = get_node("Stats")

var hurt: bool = false
var death: bool = false
var attack: bool = false

var velocity: Vector2

var attack_list: Array = [
	"swing_1",
	"swing_2"
]

var attack_index: int = 0
var current_attack: String = attack_list[attack_index]

export(String) var group_name

func _physics_process(_delta: float) -> void:
	move()
	handle_attack()
	velocity = move_and_slide(velocity)
	sprite.animate(velocity)
	
	
func move() -> void:
	var direction: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	velocity = direction * stats.speed
	
	
func handle_attack() -> void:
	if Input.is_action_just_pressed("attack") and not attack:
		attack = true
		if attack_index == attack_list.size():
			attack_index = 0
