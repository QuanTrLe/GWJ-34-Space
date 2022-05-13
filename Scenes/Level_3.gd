extends Node2D

export var scene_to : PackedScene


func _ready():
	Global.can_change_scene = true
	
	if Global.go_back == true and Global.can_go_back:
		Global.player.global_position = $Position2D.global_position
		Global.go_back = false


func _on_Interactable_body_entered(body):
	if Global.can_change_scene and body.is_in_group("Player"):
		var _unused_value = get_tree().change_scene("res://Scenes/Level_2.tscn")
		Global.go_back = true


func _on_Interactable2_body_entered(body):
	if Global.can_change_scene and body.is_in_group("Player"):
		var _unused_value = get_tree().change_scene_to(scene_to)
