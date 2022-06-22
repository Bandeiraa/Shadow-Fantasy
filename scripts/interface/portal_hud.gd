extends Control
class_name PortalHUD

onready var target_location: TextureRect = get_node("TargetLocation")
onready var buttons_container: Control = get_node("ButtonsContainer")
onready var location_label: Label = target_location.get_node("LocationLabel")

onready var object_animation: AnimationPlayer = get_node("Animation")
onready var buttons_animation: AnimationPlayer = buttons_container.get_node("Animation")

var can_interact: bool = true

var portal_scene: Area2D = null
var is_inside_button: bool = false
var is_inside_container: bool = false

func update_label(location: String) -> void:
	location_label.text = location
	
	
func on_animation_finished(anim_name: String):
	if anim_name == "show_container":
		for button in buttons_container.get_children():
			if button is TextureButton:
				button.connect("pressed", self, "on_button_pressed", [button])
				button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
				button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
				
	else:
		queue_free()
		
		
func on_button_pressed(button: TextureButton) -> void:
	if can_interact:
		button.modulate.a = 0.3
		if portal_scene.can_interact:
			match button.name:
				"LeftButton":
					portal_scene.update_region("-")
					
				"RightButton":
					portal_scene.update_region("+")
					
		yield(get_tree().create_timer(0.1), "timeout")
		if is_inside_button:
			button.modulate.a = .5
			
			
func mouse_interaction(button: TextureButton, state: String) -> void:
	if can_interact:
		match state:
			"entered":
				button.modulate.a = .5
				is_inside_button = true
				
			"exited":
				button.modulate.a = 1.0
				is_inside_button = false
				
				
func on_mouse_entered():
	is_inside_container = true
	target_location.modulate.a = .5
	
	
func on_mouse_exited():
	is_inside_container = false
	target_location.modulate.a = 1.0
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack") and is_inside_container and can_interact:
		target_location.modulate.a = 0.3
		can_interact = false
		is_inside_container = false
		object_animation.play("hide_container")
		yield(get_tree().create_timer(0.1), "timeout")
		target_location.modulate.a = 1.0
