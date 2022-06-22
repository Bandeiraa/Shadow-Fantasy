extends CanvasLayer
class_name Interface

const PORTAL: PackedScene = preload("res://scenes/interface/portal_hud.tscn")

func spawn_portal(portal_scene: Area2D) -> void:
	var portal = PORTAL.instance()
	portal.portal_scene = portal_scene
	add_child(portal)
