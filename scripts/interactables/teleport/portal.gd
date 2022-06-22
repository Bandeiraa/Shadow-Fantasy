extends Area2D
class_name TeleportPortal

onready var animation: AnimationPlayer = get_node("Animation")
onready var portal_texture: Sprite = get_node("PortalAnimation/MainSprite")

var can_interact: bool = false

var last_saved_state: int

var target_region: int
var current_region: int = 0

var region_list: Array = [
	"Ancient Ruins",
	"Grass Land",
	"Cemetery",
	"Crypt"
]

var texture_dict: Dictionary = {
	"start": [
		"res://assets/decoration/dismantled_portal/start/ancient_ruins.png",
		"res://assets/decoration/dismantled_portal/start/grass_land.png",
		"res://assets/decoration/dismantled_portal/start/cemetery.png",
		"res://assets/decoration/dismantled_portal/start/crypt.png"
	],
	
	"loop": [
		"res://assets/decoration/dismantled_portal/loop/ancient_ruins.png",
		"res://assets/decoration/dismantled_portal/loop/grass_land.png",
		"res://assets/decoration/dismantled_portal/loop/cemetery.png",
		"res://assets/decoration/dismantled_portal/loop/crypt.png"
	],
	
	"end": [
		"res://assets/decoration/dismantled_portal/end/ancient_ruins.png",
		"res://assets/decoration/dismantled_portal/end/grass_land.png",
		"res://assets/decoration/dismantled_portal/end/cemetery.png",
		"res://assets/decoration/dismantled_portal/end/crypt.png"
	]
}

func _ready() -> void:
	randomize()
	
	
func update_region(state: String) -> void:
	match state:
		"+":
			current_region += 1
			if current_region == 4:
				current_region = 0
				
			can_interact = false
			animation.play("start")
			
		"-":
			current_region -= 1
			if current_region == -1:
				current_region = 3
				
			can_interact = false
			animation.play("start")
			
			
func on_portal_body_entered(body):
	if body is Warrior:
		portal_texture.texture = load(texture_dict["start"][current_region])
		get_tree().call_group("interface", "spawn_portal", self)
		animation.play("start")
		can_interact = true
		body.freeze(false)
		
		
func on_portal_body_exited(body):
	if body is Warrior:
		portal_texture.texture = load(texture_dict["end"][current_region])
		animation.play("end")
		can_interact = false
		
		
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"start":
			get_tree().call_group("portal", "update_label", region_list[current_region])
			portal_texture.texture = load(texture_dict["loop"][current_region])
			animation.play("loop")
			can_interact = true
			
		"end":
			animation.play("idle")
