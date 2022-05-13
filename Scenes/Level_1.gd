extends Node2D

export var scene_from : PackedScene
export var scene_to : PackedScene

signal level_music


func _ready():
	Global.level_music()
	emit_signal("level_music")
	if Global.start_played_once == false:
		Global.can_change_scene = false
		var new_dialog = Dialogic.start("Start",false)
		add_child(new_dialog)
		new_dialog.connect("timeline_end",self,"after_dialog")
	else:
		Global.can_change_scene = true
	
	if Global.go_back == true and Global.can_go_back:
		Global.player.global_position = $Position2D.global_position
		Global.go_back = false
	elif Global.carrot:
		Global.player.global_position = $Position2D2.global_position
		Global.carrot = false


func after_dialog(_timeline_name):
	Global.can_change_scene = true
	Global.start_played_once = true
	

func _on_Interactable_body_entered(body):
	if Global.can_change_scene and body.is_in_group("Player"):
		get_tree().change_scene("res://Scenes/Ending_O.tscn")


func _on_Interactable2_body_entered(body):
	if Global.can_change_scene and body.is_in_group("Player"):
		var _unused_value = get_tree().change_scene_to(scene_to)


func _on_Interactable3_body_entered(body):
	if Global.can_change_scene and body.is_in_group("Player"):
		get_tree().change_scene("res://Scenes/Level_Carrot.tscn")
